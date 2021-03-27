# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsSPAWeb.Helpers do
    alias EventsSPA.Users
    alias EventsSPA.Posts
    alias EventsSPA.Invites
  
    def is_post_owner(user_id, post_id) do
      post = Post.get_post!(post_id)
      user_id == post.user_id
    end
  
    def is_post_owner_or_invitee(user_id, post_id) do
      user = Users.get_user!(user_id)
  
      is_invitee =
        Invites.list_invites(post_id)
        |> Enum.any?(fn invite -> invite.user_email == user.email end)
  
      is_invitee || is_post_owner(user_id, post_id)
    end
  end