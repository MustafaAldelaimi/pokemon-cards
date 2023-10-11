defmodule PokemonCards.Repo.Migrations.CreatePokemons do
  use Ecto.Migration

  def change do
    create table(:pokemons) do
      add :name, :string
      add :url, :string
      add :img, :string

      timestamps()
    end
  end
end
