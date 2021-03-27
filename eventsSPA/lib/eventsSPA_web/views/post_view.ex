# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsSPAWeb.PostView do
  use EventsSPAWeb, :view
  alias EventsSPAWeb.PostView
  alias EventsSPAWeb.UserView
  alias EventsSPAWeb.InviteView
  alias EventsSPAWeb.CommentView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      date: post.date,
      description: post.description,
      name: post.name,
      user: render_one(post.user, UserView, "user.json")}
      invites: render_many(post.invites, InviteView, "invite.json"),
      comments: render_many(post.comments, CommentView, "comment.json")}
  end
end
