# Some parts of code below were taken from Professor Nat Tuck's scratch repository 

defmodule EventsSPAWeb.Plugs.RequireAuth do
    import Plug.Conn
  
    def init(args), do: args
  
    def call(conn, _args) do
      token = Enum.at(get_req_header(conn, "x-auth"), 0)
  
      case Phoenix.Token.verify(conn, "user_id", token, max_age: 86400) do
        {:ok, user_id} ->
          user = EventsSPA.Users.get_user!(user_id)
          assign(conn, :current_user, user)
  
        {:error, _error} ->
          conn
          |> put_resp_header("content-type", "application/json; charset=UTF-8")
          |> send_resp(:unprocessable_entity, Jason.encode!(%{"errors" => ["Invalid."]}))
          |> halt()
      end
    end
end