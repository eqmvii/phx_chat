# Phx Chat

Recreating a simple chat app using Phoenix Live View. An updated version of [echat](https://github.com/eqmvii/echat), now with:

* Phoenix Live View (i.e., web sockets instead of long polling)
* Docker
* No React!

# Postgres connection

## Execute psql in the running postgres container

docker exec -it phx_chat_postgres_1 psql -U postgres

## create the expected database

postgres=# CREATE DATABASE phx_chat_dev;
CREATE DATABASE

# Phoenix Boilerplate:

# PhxChat

To start your Phoenix server:

  * Setup the project with `mix setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
