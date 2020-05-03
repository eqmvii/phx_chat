# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhxChat.Repo.insert!(%PhxChat.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

#####################
# Seed Test Message #
#####################

alias PhxChat.Chat

IO.puts "Seeding test message into database"

Chat.create_message(%{user: "Admin", message: "This is the test message"})

IO.puts "Done!"
