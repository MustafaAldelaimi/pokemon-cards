defmodule PokemonCards.CustomPokemonTest do
  use PokemonCards.DataCase

  alias PokemonCards.CustomPokemon

  describe "pokemons" do
    alias PokemonCards.CustomPokemon.Pokemon

    import PokemonCards.CustomPokemonFixtures

    @invalid_attrs %{name: nil, url: nil}

    test "list_pokemons/0 returns all pokemons" do
      pokemon = pokemon_fixture()
      assert CustomPokemon.list_pokemons() == [pokemon]
    end

    test "get_pokemon!/1 returns the pokemon with given id" do
      pokemon = pokemon_fixture()
      assert CustomPokemon.get_pokemon!(pokemon.id) == pokemon
    end

    test "create_pokemon/1 with valid data creates a pokemon" do
      valid_attrs = %{name: "some name", url: "some url"}

      assert {:ok, %Pokemon{} = pokemon} = CustomPokemon.create_pokemon(valid_attrs)
      assert pokemon.name == "some name"
      assert pokemon.url == "some url"
    end

    test "create_pokemon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CustomPokemon.create_pokemon(@invalid_attrs)
    end

    test "update_pokemon/2 with valid data updates the pokemon" do
      pokemon = pokemon_fixture()
      update_attrs = %{name: "some updated name", url: "some updated url"}

      assert {:ok, %Pokemon{} = pokemon} = CustomPokemon.update_pokemon(pokemon, update_attrs)
      assert pokemon.name == "some updated name"
      assert pokemon.url == "some updated url"
    end

    test "update_pokemon/2 with invalid data returns error changeset" do
      pokemon = pokemon_fixture()
      assert {:error, %Ecto.Changeset{}} = CustomPokemon.update_pokemon(pokemon, @invalid_attrs)
      assert pokemon == CustomPokemon.get_pokemon!(pokemon.id)
    end

    test "delete_pokemon/1 deletes the pokemon" do
      pokemon = pokemon_fixture()
      assert {:ok, %Pokemon{}} = CustomPokemon.delete_pokemon(pokemon)
      assert_raise Ecto.NoResultsError, fn -> CustomPokemon.get_pokemon!(pokemon.id) end
    end

    test "change_pokemon/1 returns a pokemon changeset" do
      pokemon = pokemon_fixture()
      assert %Ecto.Changeset{} = CustomPokemon.change_pokemon(pokemon)
    end
  end
end
