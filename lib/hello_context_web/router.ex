defmodule HelloContextWeb.Router do
  use HelloContextWeb, :router

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

  scope "/", HelloContextWeb do
    pipe_through :browser

    get "/", PageController, :index
    # resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete],
                                              singleton: true
    get "/login_out", SessionController, :login_out
  end

  scope "/", HelloContextWeb do
    pipe_through :browser

    resources "/users", UserController
  end
  
  scope "/cms", HelloContextWeb.CMS, as: :cms do
    pipe_through [:browser, Plug.Auth]

    resources "/pages", PageController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloContextWeb do
  #   pipe_through :api
  # end
end
