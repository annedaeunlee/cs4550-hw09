# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsSPA.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string

    belongs_to :user, EventsSPA.Users.User
    belongs_to :post, EventsSPA.Posts.Post


    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :user_id, :post_id])
    |> validate_required([:body, :user_id, :post_id])
  end

end
