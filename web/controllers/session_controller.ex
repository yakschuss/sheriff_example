defmodule SheriffExampleApp.SessionController do
  @moduledoc false

  use SheriffExampleApp.Web, :controller

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case check_credentials(email, password) do
			{:ok, user} ->
				conn
				|> put_flash(:info, "Signed In!")
				|> redirect(to: administrator_page_path(conn, :index)
 	    {:error, changeset} ->
        conn
        |> put_flash(:error, "Invalid Credentials")
				|> render("new.html")
		end
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> put_flash(:info, "Successfully signed out")
    |> redirect(to: "/")
  end

  defp check_credentials(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- find_by_email(email),
      do: verify_password(password, user)
  end

  defp find_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        dummy_checkpw()
        {:error, "User with email '#{email}' not found"}
      user ->
        {:ok, user}
    end

  end

  defp verify_password(password, %User{} = user) when is_binary(password) do
    if checkpw(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end
end
