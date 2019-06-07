defmodule AppWeb.TodoController do
  use AppWeb, :controller
  alias Phoenix.LiveView
  alias App.Ctx
  alias App.Ctx.Todo

  def index(conn, _params) do
    # todos = Ctx.list_todos_by_priority()
    # render(conn, "index.html", todos: todos)
    LiveView.Controller.live_render(conn, AppWeb.TodoLive, session: %{})
  end

  def new(conn, _params) do
    changeset = Ctx.change_todo(%Todo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo" => todo_params}) do
    case Ctx.create_todo(todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo created successfully.")
        |> redirect(to: Routes.todo_path(conn, :show, todo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Ctx.get_todo!(id)
    render(conn, "show.html", todo: todo)
  end

  def edit(conn, %{"id" => id}) do
    todo = Ctx.get_todo!(id)
    changeset = Ctx.change_todo(todo)
    render(conn, "edit.html", todo: todo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Ctx.get_todo!(id)

    case Ctx.update_todo(todo, todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo updated successfully.")
        |> redirect(to: Routes.todo_path(conn, :show, todo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", todo: todo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Ctx.get_todo!(id)
    {:ok, _todo} = Ctx.delete_todo(todo)

    conn
    |> put_flash(:info, "Todo deleted successfully.")
    |> redirect(to: Routes.todo_path(conn, :index))
  end
end
