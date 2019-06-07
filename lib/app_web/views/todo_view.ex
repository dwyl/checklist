defmodule AppWeb.TodoView do
  use AppWeb, :view

  def statuslist do
    Enum.map(App.StatusList.statuslist, fn(atom) ->
      {atom_to_human_str(atom), atom}
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

  def id_status(todo, atom) do
    "#{todo.id}-#{atom}"
  end
end
