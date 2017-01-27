defmodule SheriffExampleApp.LoggedIn.AuthorizedController do
  use SheriffExampleApp.Web, :controller

  def index(conn, _params) do
    # require IEx; IEx.pry
    # conn = conn.private[:sheriff_resource]
    render(conn, "index.html")
  end
end
