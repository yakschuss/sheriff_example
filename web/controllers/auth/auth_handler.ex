defmodule SheriffExampleApp.AuthHandler do
  use SheriffExampleApp.Web, :controller

  def unauthenticated(conn, _params) do
    conn
      |> put_flash(:error, "You're not logged in!")
      |> redirect(to: session_path(conn, :new))
  end
end

