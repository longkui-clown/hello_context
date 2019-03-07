defmodule Plug.Auth do
  @moduledoc """
  A Plug to convert `HEAD` requests to `GET` requests.

  ## Examples

      Plug.Head.call(conn, [])
  """

  @behaviour Plug

  import Plug.Conn
  alias HelloContext.Accounts

  def init(_), do: []

  def call(conn, _) do
    call_1(conn)
  end

  defp call_1(conn) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      user_id ->
        assign(conn, :current_user, Accounts.get_user!(user_id))
    end
  end
  
end