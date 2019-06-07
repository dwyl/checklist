defmodule AppWeb.TodoLive do
  use Phoenix.LiveView

  @topic "live"

  def render(assigns) do
    AppWeb.TodoView.render("index_live.html", assigns)
  end

  def mount(session, socket) do
    AppWeb.Endpoint.subscribe(@topic)
    todos = App.Ctx.list_todos_by_priority()
    {:ok, assign(socket, todos: todos)}
  end

  def handle_event("change_status", value, socket) do
    IO.inspect(value, label: "value")
    status = App.StatusList.statuslist() |> Enum.random()
    App.Ctx.get_todo!(value) |> App.Ctx.update_todo(%{status: status})

    todos = App.Ctx.list_todos_by_priority()
    AppWeb.Endpoint.broadcast_from(self(), @topic, "update", %{todos: todos})
    {:noreply, assign(socket, todos: todos)}
  end

  def handle_info(msg, socket) do
    IO.inspect(msg, label: ">> msg")
    {:noreply, assign(socket, todos: msg.payload.todos)}
  end
end
