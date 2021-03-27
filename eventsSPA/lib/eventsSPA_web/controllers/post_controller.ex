# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsSPAWeb.PostController do
  use EventsSPAWeb, :controller

  alias EventsSPA.Posts
  alias EventsSPA.Posts.Post
  alias EventsSPAWeb.Helpers

  action_fallback EventsSPAWeb.FallbackController

  plug EventsSPA.Plugs.RequireAuth when action in [:create, :update, :delete, :show]


  def index(conn, _params) do
    current_user = conn.assigns[:current_user]

    posts =
      Posts.list_posts()
      |> Enum.filter(fn post -> Helpers.is_post_owner_or_invitee(current_user.id, post.id) end)

    render(conn, "index.json", posts: posts)
  end

  # def create(conn, %{"post" => post_params}) do
  #   with {:ok, %Post{} = post} <- Posts.create_post(post_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", Routes.post_path(conn, :show, post))
  #     |> render("show.json", post: post)
  #   end
  # end

  # def create(conn, %{"name" => name, "password" => password}) do
  #   user = PhotoBlog.Users.get_user_by_name!(name)
  #   # TODO: Verify password
  #   sess = %{
  #     user_id: user.id,
  #     name: user.name,
  #     token: Phoenix.Token.sign(conn, "user_id", user.id),
  #   }
  #   conn
  #   |> put_resp_header("content-type", "application/json; charset=UTF-8")
  #   |> send_resp(:created, Jason.encode!(sess))
  # end

  def create(conn, post_params) do
    user = conn.assigns[:current_user]
    result = post_params |> Map.put("user_id", user.id) |> Posts.create_post()

    case result do
      {:ok, %Post{} = post} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.post_path(conn, :show, post))
        |> render("show.json", post: post)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    current_user = conn.assigns[:current_user]

    if Helpers.is_post_owner_or_invitee(current_user.id, id) do
      post = Posts.get_post!(id)
      render(conn, "show.json", post: post)
    else
      conn
      |> put_resp_header(
        "content-type",
        "application/json; charset=UTF-8"
      )
      |> send_resp(
        :unauthorized,
        Jason.encode!(%{errors: ["Failed to show."]})
      )
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = conn.assigns[:post]
    case Posts.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_status(:accepted)
        |> render("show.json", post: post)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_resp_header("content-type", "application/json; charset=UTF-8")
        |> send_resp(406, Jason.encode!(%{error: "Failed to update."}))
    end 
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)

    with {:ok, %Post{}} <- Posts.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
