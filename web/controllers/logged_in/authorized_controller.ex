defmodule SheriffExampleApp.LoggedIn.AuthorizedController do
  use SheriffExampleApp.Web, :controller

  import Sheriff.Plug, only: [current_resource: 1]

  def index(conn, _params) do
    users = current_resource(conn)
    render(conn, "index.html", users: users)
  end
end
