defmodule PokemonCards.Repo do
  use Ecto.Repo,
    otp_app: :pokemon_cards,
    adapter: Ecto.Adapters.Postgres
end
