defmodule AppWeb.TodoLive do
  use Phoenix.LiveView

  def render(assigns) do
    IO.inspect(assigns, label: "assigns")
    AppWeb.TodoView.render("index_live.html", assigns)
  end

  def mount(_session, socket) do
    todos = App.Ctx.list_todos_by_priority()
    {:ok, assign(socket, todos: todos)}
  end

  def handle_event("change_status", _value, socket) do
    status = App.StatusList.statuslist() |> Enum.random()
    App.Ctx.get_todo!(5) |> App.Ctx.update_todo(%{status: status})

    todos = App.Ctx.list_todos_by_priority()
    {:noreply, assign(socket, todos: todos)}
  end

  # def handle_info(:create_org, socket) do
  #   # {:ok, org} = App.create_org()
  #   # send(self(), {:create_repo, org})
  #   {:noreply, assign(socket, deploy_step: "Creating GitHub org...")}
  # end
  #
  # def handle_info({:create_repo, org}, socket) do
  #   # {:ok, repo} = App.create_repo(org)
  #   # send(self(), {:push_contents, repo})
  #   {:noreply, assign(socket, deploy_step: "Creating GitHub repo...")}
  # end
  #
  # def handle_info({:push_contents, repo}, socket) do
  #   # :ok = App.push_contents(repo)
  #   # send(self(), :done)
  #   {:noreply, assign(socket, deploy_step: "Pushing to repo...")}
  # end

  def handle_info(:done, socket) do
    {:noreply, assign(socket, deploy_step: "Done!")}
  end

end
