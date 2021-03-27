# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsSPA.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string

    has_many :posts, EventsSPA.Posts.Post
    has_many :comments, EventsSPA.Comments.Comment

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_password(attrs["password"])
    |> add_password_hash(attrs["password"])
    |> validate_required([:name, :email, :password_hash])
    |> unique_constraint(:email)
  end

  def add_password_hash(changeset, nil) do
    changeset
  end

  def add_password_hash(changeset, password) do
    change(changeset, Argon2.add_hash(password))
  end

  def validate_password(changeset, password) do
    changeset =
      if String.length(password) < 8 do
        Ecto.Changeset.add_error(
          changeset,
          :password_hash,
          "Password must be at least 8 characters long."
        )
      else
        changeset
      end

    if password in ["password", "P4ssw0rd"] do
      Ecto.Changeset.add_error(changeset, :password_hash, "Please choose a more secure password.")
    else
      changeset
    end
  end




end
