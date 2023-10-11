defmodule PokemonCardsWeb.PokemonControllerTest do
  use PokemonCardsWeb.ConnCase

  import PokemonCards.CustomPokemonFixtures

  alias PokemonCards.CustomPokemon.Pokemon

  @create_attrs %{
    name: "some name",
    url: "some url"
  }
  @update_attrs %{
    name: "some updated name",
    url: "some updated url"
  }
  @invalid_attrs %{name: nil, url: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pokemons", %{conn: conn} do
      conn = get(conn, ~p"/api/pokemons")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pokemon" do
    test "renders pokemon when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/pokemons", pokemon: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/pokemons/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name",
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/pokemons", pokemon: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update pokemon" do
    setup [:create_pokemon]

    test "renders pokemon when data is valid", %{conn: conn, pokemon: %Pokemon{id: id} = pokemon} do
      conn = put(conn, ~p"/api/pokemons/#{pokemon}", pokemon: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/pokemons/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name",
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, pokemon: pokemon} do
      conn = put(conn, ~p"/api/pokemons/#{pokemon}", pokemon: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pokemon" do
    setup [:create_pokemon]

    test "deletes chosen pokemon", %{conn: conn, pokemon: pokemon} do
      conn = delete(conn, ~p"/api/pokemons/#{pokemon}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/pokemons/#{pokemon}")
      end
    end
  end

  defp create_pokemon(_) do
    pokemon = pokemon_fixture()
    %{pokemon: pokemon}
  end
end
