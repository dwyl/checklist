defmodule AppWeb.TodoView do
  use AppWeb, :view

  def statuslist do
    Enum.map(App.StatusList.statuslist, fn(atom) ->
      {atom_to_human_str(atom), atom}
    end)
  end

  def statusliststring do
    Enum.map(App.StatusList.statuslist, fn(atom) ->

      atom
      |> Atom.to_string()
    end)
  end

  def atom_to_human_str(atom) do
    atom
    |> Atom.to_string()
    |> human_readble_status()
  end

  def human_readble_status(str) do
    str
    |> String.replace("_", " ")
    |> String.capitalize
  end

  def selected(todo_status, status) do
    # IO.inspect(todo_status, label: "todo_status")
    # IO.inspect(status, label: "status")

    if Atom.to_string(todo_status) == status do
      "selected"
    else
      ""
    end
  end

end
