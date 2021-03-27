# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsSPA.Repo.Migrations.CreateInvites do
  use Ecto.Migration

  def change do
    create table(:invites) do
      add :response, :string, default: "No response yet."
      add :post_id, references(:posts, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:invites, [:post_id, :user_id])

  end
end
