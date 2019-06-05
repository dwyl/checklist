defmodule AppWeb.TodoView do
  use AppWeb, :view

  def statuslist do
    Enum.map(App.StatusList.statuslist, fn (s) ->
        Atom.to_string(s)
        |> String.replace("_", " ")
        |> String.capitalize
      end)
    # |> IO.inspect(label: "statuslist string")
  end
end
