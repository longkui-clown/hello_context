defmodule HelloContextWeb.UserView do
  use HelloContextWeb, :view
  alias HelloContext.Accounts

  def get_user_name(conn) do
    case Plug.Conn.get_session(conn, :user_id) do
      id when is_integer(id) ->
        Accounts.get_user!(id).name
      _ ->
        conn
        |> Plug.Conn.clear_session()
        |> redirect(to: Routes.page_path(conn, :index))
        |> halt()
        ""
    end
  end

end
