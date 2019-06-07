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

  def handle_event("change_status", value, socket) do
    IO.inspect(value, label: "value")
    status = App.StatusList.statuslist() |> Enum.random()
    App.Ctx.get_todo!(value) |> App.Ctx.update_todo(%{status: status})

    todos = App.Ctx.list_todos_by_priority()
    AppWeb.Endpoint.broadcast_from(self(), @topic, "update", %{todos: todos})
    {:noreply, assign(socket, todos: todos)}
  end

  def handle_event("update_status", value, socket) do
    IO.inspect(value, label: "value")

    # value should be todo.id_status so we can split on "_" to get the id and status ...
    # @robstallion this is the part that is not yet working ... https://git.io/fjzEm
    parts = String.split(value, "_")
    id = parts[0]
    status = parts[1]
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
