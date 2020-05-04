# Phx Chat

Recreating a simple chat app using Phoenix Live View. An updated version of [echat](https://github.com/eqmvii/echat), now with:

* Phoenix Live View (i.e., web sockets instead of long polling)
* Docker
* Redis
* PostgreSQL
* No React (or, really, any JavaScript)

# Postgres connection

## Execute psql in the running postgres container

`docker exec -it phx_chat_postgres_1 psql -U postgres`

## create the expected database

```
postgres=# CREATE DATABASE phx_chat_dev;
CREATE DATABASE
```

## Sees the database

```
phx_chat_dev=# \l
                                  List of databases
     Name     |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
--------------+----------+----------+------------+------------+-----------------------
 phx_chat_dev | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 postgres     | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0    | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
              |          |          |            |            | postgres=CTc/postgres
 template1    | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
              |          |          |            |            | postgres=CTc/postgres
```

## Connect to that db

```
postgres=# \c phx_chat_dev
You are now connected to database "phx_chat_dev" as user "postgres".
phx_chat_dev=# select * from messages;
 id | message | inserted_at | updated_at
----+---------+-------------+------------
(0 rows)

phx_chat_dev=# \dt
               List of relations
 Schema |       Name        | Type  |  Owner
--------+-------------------+-------+----------
 public | messages          | table | postgres
 public | schema_migrations | table | postgres
(2 rows)
```

# Migrations

## Create with context

(preferred)

`mix phx.gen.context Chat Message messages user:string message:string`

## Create a migration

`mix ecto.gen.migration add_messages_table`

## Run a migration

`mix ecto.migrate`

## Roll back a migration

`mix ecto.rollback --step 1`

# Generators

## Messages Context

`mix phx.gen.context Chat Message messages user:string message:string`

# Seed Messages

(1) Ensure the database has been created via psql or otherwise

(2) In the chat container, execute:

`mix run priv/repo/seeds.exs`

# Format

```
dbash chat
mix format mix.exs "lib/**/*.{ex,exs}" "test/**/*.{ex,exs}"
```

# Heroku Deployment

Followed steps from [https://hexdocs.pm/phoenix/heroku.html](This Guide)

`heroku create eqmvii-phx-chat --buildpack hashnuke/elixir`

`touch elixir_buildpack.config`

`heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git`

`touch phoenix_static_buildpack.config`

## Run Migrations

`heroku run mix ecto.migrate`

## DB creation

`heroku addons:create heroku-postgresql:hobby-dev`

`heroku config:set POOL_SIZE=18`

## Redis

Heroku Redis added manually via Web UI

`heroku config:set PHOENIX_REDIS_URI="[REDACTED]"`

`heroku config:set REDIS_PUBSUB_NODE_NAME="testone"`

(may need to revisit -- how to make unique for multiple servers?)

## Secret Key Base

`heroku config:set SECRET_KEY_BASE="[REDACTED]"`

# Testing

bash into the container (`dbash chat`), then `mix test`

= = = = = = = = = = = = = = = = = = = = = = = =

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
