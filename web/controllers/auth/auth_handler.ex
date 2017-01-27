defmodule SheriffExampleApp.AuthHandler do
  use SheriffExampleApp.Web, :controller

  def resource_missing(conn), do: error_resp(conn, :not_found)

  def unauthorized(conn), do: error_resp(conn, :unauthorized)

  def unauthenticated(conn), do: error_resp(conn, :forbidden)
  def unauthenticated(conn, _params) do
    conn
      |> put_flash(:error, "You're not logged in!")
      |> redirect(to: session_path(conn, :new))
  end

  defp error_resp(conn, status) do
    json = Poison.encode!(%{"error" => Atom.to_string(status)})
    send_resp(conn, status, json)
  end
end

