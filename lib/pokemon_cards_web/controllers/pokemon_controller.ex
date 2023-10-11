defmodule PokemonCardsWeb.PokemonController do
  use PokemonCardsWeb, :controller

  alias PokemonCards.Repo
  alias PokemonCards.CustomPokemon
  alias PokemonCards.CustomPokemon.Pokemon

  action_fallback PokemonCardsWeb.FallbackController

  def home(conn, _params) do
    pokemons = CustomPokemon.list_pokemons()
    IO.inspect(pokemons)
    render(conn, :home, pokemons: pokemons)
  end

  def index(conn, _params) do
    pokemons = CustomPokemon.list_pokemons()
    render(conn, :index, pokemons: pokemons)
  end

  def create(conn, %{"pokemon" => pokemon_params}) do
    with {:ok, %Pokemon{} = pokemon} <- CustomPokemon.create_pokemon(pokemon_params) do
      conn
      |> put_status(:created)
      |> render(:show, pokemon: pokemon)
    end
  end

  def show(conn, %{"id" => id}) do
    pokemon = CustomPokemon.get_pokemon!(id)
    render(conn, :show, pokemon: pokemon)
  end

  def update(conn, %{"id" => id, "pokemon" => pokemon_params}) do
    pokemon = CustomPokemon.get_pokemon!(id)

    with {:ok, %Pokemon{} = pokemon} <- CustomPokemon.update_pokemon(pokemon, pokemon_params) do
      render(conn, :show, pokemon: pokemon)
    end
  end

  def delete(conn, %{"id" => id}) do
    pokemon = CustomPokemon.get_pokemon!(id)

    with {:ok, %Pokemon{}} <- CustomPokemon.delete_pokemon(pokemon) do
      send_resp(conn, :no_content, "")
    end
  end

  def reset(conn, _params) do
    Repo.delete_all(Pokemon)

    pokemon_data = fetch_pokemon_data()
    Enum.each(pokemon_data, fn pokemon ->
      Repo.insert!(%Pokemon{
        name: pokemon["name"],
        url: pokemon["url"],
        img: fetch_pokemon_image(pokemon["url"])
      })
    end)
    json(conn, %{message: "Database reset and populated with new data."})
  end

  def fetch_pokemon_data do
    pokemon_api_url = "https://pokeapi.co/api/v2/pokemon?limit=10"
    {:ok, response} = HTTPoison.get(pokemon_api_url)
    {:ok, data} = Jason.decode(response.body)
    data["results"]
  end

  def fetch_pokemon_image(url) do
    {:ok, keys_check} = HTTPoison.get(url)
    {:ok, keys_data} = Jason.decode(keys_check.body)
    keys_data["sprites"]["front_default"]
  end
end
