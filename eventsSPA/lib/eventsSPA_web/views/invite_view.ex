# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsSPAWeb.InviteView do
  use EventsSPAWeb, :view
  alias EventsSPAWeb.InviteView
  alias EventsSPAWeb.UserView

  def render("index.json", %{invites: invites}) do
    %{data: render_many(invites, InviteView, "invite.json")}
  end

  def render("show.json", %{invite: invite}) do
    %{data: render_one(invite, InviteView, "invite.json")}
  end

  def render("invite.json", %{invite: invite}) do
    %{id: invite.id,
      response: invite.response,
      user: render_one(invite.user, UserView, "user.json"),
      post_id: invite.post_id
    }
  end
end
