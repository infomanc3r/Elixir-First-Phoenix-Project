# First API using Elixir + Phoenix

## Purpose
This demo was created so that I could learn the [Phoenix framework](https://www.phoenixframework.org/) and practice writing [Elixir](https://elixir-lang.org/) to set up an API with a dockerized [Postgres](https://www.postgresql.org/) integration. The API could be adapted for other purposes and may provide you with a useful starting point.

## Prerequisites

  * [Erlang 24 or later + Elixir 1.15 or later](https://elixir-lang.org/install.html) - this install guide from the official Elixir site walks through installing both languages for your OS.
  * [Hex package manager](https://hex.pm/docs/usage) - should install automatically with Elixir + Mix.
  * A [PostgreSQL database](https://www.postgresql.org/download/) - the preferred way for this to set up would be using [Docker](https://www.docker.com/) and the latest postgres image. This can be done from the command line using these commands with the following flags set:
  ```
  docker pull postgres
  
  docker run --name EXAMPLE_NAME -p 5432:5432 -e POSTGRES_USER=EXAMPLE_USER -e POSTGRES_PASSWORD=EXAMPLE_PASS -d postgres
  ```

  It is important that you set a custom username and password! Malicious actors scan for Postgres servers with the default username and password and cryptojack them. Not a problem if you're staying on localhost, but important to keep in mind if you're deploying to a server.
  

## Setup

  * In the config folder, find the dev.exs file and change the username, password, and database name to match your Postgres server.
  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

The default port is 4000 and you may access the API using [`localhost:4000`](http://localhost:4000) from your browser. Routing is listed in router.ex and the .ex files in the 'controllers' folder.