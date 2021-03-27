# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsSPAWeb.CommentController do
  use EventsSPAWeb, :controller

  alias EventsSPA.Comments
  alias EventsSPA.Comments.Comment
  alias EventsSPAWeb.Helpers

  action_fallback EventsSPAWeb.FallbackController

  plug EventsSPA.Plugs.RequireAuth when action in [:create, :update, :delete, :show]


  def index(conn, _params) do
    comments = Comments.list_comments()
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"comment" => comment_params}) do
    current_user = conn.assigns[:current_user]

    if Helpers.is_post_owner_or_invitee(current_user.id, comment_params["post_id"]) do
      comment_params = Map.put(comment_params, "user_id", current_user.id)

      case Comments.create_comment(comment_params) do
        {:ok, %Comment{} = comment} ->
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.comment_path(conn, :show, comment))
          |> render("show.json", comment: comment)

        {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> put_status(:bad_request)
          |> render("error.json", changeset: changeset)
      end
    else
      conn
      |> put_resp_header(
        "content-type",
        "application/json; charset=UTF-8"
      )
      |> send_resp(
        :unauthorized,
        Jason.encode!(%{errors: ["Must be owner or invitee to create this event."]})
      )
    end
  end

  def show(conn, %{"id" => id}) do
    current_user = conn.assigns[:current_user]

    if Helpers.is_post_owner_or_invitee(current_user.id, id) do
      comments = Comments.list_comments(id)
      render(conn, "index.json", comments: comments)
    else
      conn
      |> put_resp_header(
        "content-type",
        "application/json; charset=UTF-8"
      )
      |> send_resp(
        :unauthorized,
        Jason.encode!(%{errors: ["You are not an owner or invitee of this event."]})
      )
    end
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Comments.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Comments.update_comment(comment, comment_params) do
      render(conn, "show.json", comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)

    with {:ok, %Comment{}} <- Comments.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
