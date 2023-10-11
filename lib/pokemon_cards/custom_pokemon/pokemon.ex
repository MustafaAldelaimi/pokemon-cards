defmodule PokemonCards.CustomPokemon.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pokemons" do
    field :name, :string
    field :url, :string
    field :img, :string

    timestamps()
  end

  @doc false
  def changeset(pokemon, attrs) do
    pokemon
    |> cast(attrs, [:name, :url])
    |> validate_required([:name, :url])
  end
end
