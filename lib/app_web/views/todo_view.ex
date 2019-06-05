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
    |> String.replace("_", " ")
    |> String.capitalize
  end
end
