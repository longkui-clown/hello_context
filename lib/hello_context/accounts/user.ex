defmodule HelloContext.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias HelloContext.Accounts.Credential

  schema "users" do
    field :name, :string
    field :username, :string
    field :pwd, :string
    has_one :credential, Credential

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username, :pwd])
    |> validate_required([:name, :username, :pwd])
    |> unique_constraint(:username)
  end
end
