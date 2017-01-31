defmodule SheriffExampleApp.Router do
  use SheriffExampleApp.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :authentication do
    plug Guardian.Plug.EnsureAuthenticated, handler: SheriffExampleApp.AuthHandler
  end

  pipeline :authorization do
    plug Sheriff.Plug.LoadResource, loader: SheriffExampleApp.UserLoader
    plug Sheriff.Plug.EnforceLaw, law: SheriffExampleApp.UserLaw, resource_key: :guardian_default_resource
  end

  scope "/", SheriffExampleApp do
    pipe_through :browser

    resources "/users", UserController, only: [:new, :create]
    resources "/sessions", SessionController, only: [:create, :delete, :new]

    get "/", PageController, :index
  end

  scope "/logged_in", SheriffExampleApp.LoggedIn do
    pipe_through [:browser, :browser_session, :authentication]

    resources "/posts", PostController, only: [:index]

    scope "/admin" do
      pipe_through [:authorization]
      resources "/secret_stuff", AuthorizedController, only: [:index]
    end
  end
end
