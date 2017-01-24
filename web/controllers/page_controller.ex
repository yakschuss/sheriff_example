defmodule SheriffExampleApp.PageController do
  use SheriffExampleApp.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
