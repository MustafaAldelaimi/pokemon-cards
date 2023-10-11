# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PokemonCards.Repo.insert!(%PokemonCards.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PokemonCards.Repo
alias PokemonCards.CustomPokemon.Pokemon
alias PokemonCardsWeb.PokemonController

data = PokemonController.fetch_pokemon_data()
Enum.each(data, fn pokemon ->
  Repo.insert!(%Pokemon{
    name: pokemon["name"],
    url: pokemon["url"],
    img: PokemonController.fetch_pokemon_image(pokemon["url"])
  })
end)
