defmodule SheriffExampleApp.LoggedIn.PostController do
  use SheriffExampleApp.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
