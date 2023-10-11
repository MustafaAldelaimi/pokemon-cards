defmodule PokemonCardsWeb.PageController do
  use PokemonCardsWeb, :controller

  def home(conn, _params) do
    pokemon_list = HTTPoison.get!("https://pokeapi.co/api/v2/pokemon?limit=151")
    IO.inspect(pokemon_list)
    render(conn, :home, layout: false)
  end
end
