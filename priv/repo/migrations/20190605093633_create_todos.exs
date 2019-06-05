defmodule App.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :title, :string
      add :status, StatusEnum.type()
      add :priority, :integer
      add :time_estimate, :integer
      add :deadline, :naive_datetime
      add :schedule, :naive_datetime
      add :assignee, :string
      add :owner, :string

      timestamps()
    end

  end
end
