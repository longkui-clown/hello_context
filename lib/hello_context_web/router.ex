defmodule HelloContextWeb.Router do
  use HelloContextWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :ensure_session_not_timeout
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

  defp ensure_session_not_timeout(conn, _) do
    now = Utils.timestamp()
    timeout_s = Application.get_env(:hello_context, :timeout_s, 3600)
    case {get_session(conn, :timeout), get_session(conn, :user_id)} do
      {expire_timestamp, _} when expire_timestamp > now ->
        conn
        |> put_session(:timeout, now + timeout_s)

      {_, nil} ->
        conn
        |> put_session(:timeout, now + timeout_s)
      
      _ ->
        conn
        |> clear_session()
        |> Phoenix.Controller.put_flash(:error, "Long time no operation, Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloContextWeb do
  #   pipe_through :api
  # end
end
