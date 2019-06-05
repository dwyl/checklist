defmodule App.Ctx.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :assignee, :string
    field :deadline, :naive_datetime
    field :owner, :string
    field :priority, :integer
    field :schedule, :naive_datetime
    field :status, StatusEnum # <--- lib/ecto_enums.ex
    field :time_estimate, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :status, :priority, :time_estimate, :deadline, :schedule, :assignee, :owner])
    |> validate_required([])
  end
end
