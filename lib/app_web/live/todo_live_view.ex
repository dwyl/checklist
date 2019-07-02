defmodule AppWeb.TodoLive do
  use Phoenix.LiveView

  @topic "live"

  def render(assigns) do
    AppWeb.TodoView.render("index_live.html", assigns)
  end

  def mount(_session, socket) do
    AppWeb.Endpoint.subscribe(@topic)
    todos = App.Ctx.list_todos_by_priority()
    {:ok, assign(socket, todos: todos)}
  end

  def handle_event("update_status", value, socket) do
    [key] = value |> Map.keys() |> Enum.filter(&String.contains?(&1, "status_"))
    [_, id] = String.split(key, "_")
    status = value[key]["status"]
    App.Ctx.get_todo!(id) |> App.Ctx.update_todo(%{status: status})

    todos = App.Ctx.list_todos_by_priority()
    AppWeb.Endpoint.broadcast_from(self(), @topic, "update", %{todos: todos})
    {:noreply, assign(socket, todos: todos)}
  end

  def handle_info(msg, socket) do
    IO.inspect(msg, label: ">> msg")
    {:noreply, assign(socket, todos: msg.payload.todos)}
  end
end
