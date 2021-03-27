# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsSPA.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :date, :naive_datetime
    field :description, :string
    field :name, :string

    belongs_to :user, EventsSPA.Users.User
    has_many :invites, EventsSPA.Invites.Invite
    has_many :comments, EventsSPA.Comments.Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:date, :description, :name, :user_id])
    |> validate_required([:date, :description, :name, :user_id])
  end
end
