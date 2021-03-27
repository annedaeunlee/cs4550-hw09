defmodule EventsSPAWeb.PageController do
  use EventsSPAWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
