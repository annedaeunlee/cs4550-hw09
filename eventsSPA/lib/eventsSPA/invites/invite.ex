# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsSPA.Invites.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invites" do
    field :response, :string, default: "No response yet."

    belongs_to :user, EventsSPA.Users.User
    belongs_to :post, EventsSPA.Posts.Post

    timestamps()
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, [:response, :user_id, :post_id])
    |> validate_required([:response, :user_id, :post_id])
    |> unique_constraint([:post_id, :user_id])

  end
end
