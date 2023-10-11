defmodule PokemonCards.CustomPokemonFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PokemonCards.CustomPokemon` context.
  """

  @doc """
  Generate a pokemon.
  """
  def pokemon_fixture(attrs \\ %{}) do
    {:ok, pokemon} =
      attrs
      |> Enum.into(%{
        name: "some name",
        url: "some url"
      })
      |> PokemonCards.CustomPokemon.create_pokemon()

    pokemon
  end
end
