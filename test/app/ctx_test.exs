defmodule App.CtxTest do
  use App.DataCase

  alias App.Ctx

  describe "todos" do
    alias App.Ctx.Todo

    @valid_attrs %{assignee: "some assignee", deadline: ~N[2010-04-17 14:00:00], owner: "some owner", priority: 42, schedule: ~N[2010-04-17 14:00:00], status: "some status", time_estimate: 42, title: "some title"}
    @update_attrs %{assignee: "some updated assignee", deadline: ~N[2011-05-18 15:01:01], owner: "some updated owner", priority: 43, schedule: ~N[2011-05-18 15:01:01], status: "some updated status", time_estimate: 43, title: "some updated title"}
    @invalid_attrs %{assignee: nil, deadline: nil, owner: nil, priority: nil, schedule: nil, status: nil, time_estimate: nil, title: nil}

    def todo_fixture(attrs \\ %{}) do
      {:ok, todo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ctx.create_todo()

      todo
    end

    test "list_todos/0 returns all todos" do
      todo = todo_fixture()
      assert Ctx.list_todos() == [todo]
    end

    test "get_todo!/1 returns the todo with given id" do
      todo = todo_fixture()
      assert Ctx.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo" do
      assert {:ok, %Todo{} = todo} = Ctx.create_todo(@valid_attrs)
      assert todo.assignee == "some assignee"
      assert todo.deadline == ~N[2010-04-17 14:00:00]
      assert todo.owner == "some owner"
      assert todo.priority == 42
      assert todo.schedule == ~N[2010-04-17 14:00:00]
      assert todo.status == "some status"
      assert todo.time_estimate == 42
      assert todo.title == "some title"
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ctx.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{} = todo} = Ctx.update_todo(todo, @update_attrs)
      assert todo.assignee == "some updated assignee"
      assert todo.deadline == ~N[2011-05-18 15:01:01]
      assert todo.owner == "some updated owner"
      assert todo.priority == 43
      assert todo.schedule == ~N[2011-05-18 15:01:01]
      assert todo.status == "some updated status"
      assert todo.time_estimate == 43
      assert todo.title == "some updated title"
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todo = todo_fixture()
      assert {:error, %Ecto.Changeset{}} = Ctx.update_todo(todo, @invalid_attrs)
      assert todo == Ctx.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{}} = Ctx.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> Ctx.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset" do
      todo = todo_fixture()
      assert %Ecto.Changeset{} = Ctx.change_todo(todo)
    end
  end
end
