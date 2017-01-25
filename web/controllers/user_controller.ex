defmodule SheriffExampleApp.UserController do
  @moduledoc false

  use SheriffExampleApp.Web, :controller

  alias SheriffExampleApp.User

  def new(conn, _params) do
    render(conn, "new.html", changeset: User.register_changeset(%User{}))
  end

  def create(conn, %{"user" => user_params}) do
    record =
      %User{}
      |> User.register_changeset(user_params)
      |> Repo.insert
    case record do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Success")
        |> redirect(to: session_path(conn, :new))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
