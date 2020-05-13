# phx_chat:1 - development version
# docker build -t eqmvii/phx_chat:1 .
# Simple container to run phoenix apps

FROM elixir:1.9.4

RUN mix local.hex --force && \
    mix local.rebar --force

RUN mkdir /app
WORKDIR /app

# inotify-tools is used for live reload while developing
RUN apt-get update && \
    apt-get install -y inotify-tools && \
    curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
    apt-get install -y nodejs


EXPOSE 4000

# This will run be default, and won't work until the app has phoenix installed
CMD [ "mix", "phx.server" ]

#########
# USAGE #
#########

#############
# First run #
#############

# Build the image:
# docker build --tag [TAGNAME] .

# Run the container, bind mounting to PWD, executing bash for persistance instead of the default mix phx.server
# docker run -d -it --mount type=bind,source="$(pwd)",target=/app [TAGNAME] bash

# Bash into your container:
# docker exec -it [CONTAINERID] bash

# Install Phoenix to generate your starter files:
# mix archive.install hex phx_new 1.5.1

# Generate your new phoenix app (may need to move directories around to avoid an extra folder)
# cd /app && mix phx.new --no-ecto test_app

# install dependencies and build weback
# cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode development

################
# Existing App #
################

# Build the image:
# docker build --tag [TAGNAME] .

# Run the container, bind mounting to PWD, executing bash for persistance instead of the default mix phx.server
# docker run -d --name phxchat -p 8000:4000 --mount type=bind,source="$(pwd)",target=/app [TAGNAME]

# See the container running
# docker ps

# log the contianer
# docker logs --follow phxchat

###########
# Utility #
###########

#### Bash In (docker-compose version) #

# docker exec -it liveviewtest_webapp_1 bash

##### Run a container with sleep to poke around if the app breaks

# docker run --name phxchat -p 8000:4000 --mount type=bind,source="$(pwd)",target=/app phxchat1.0 sleep 100000
# docker ps
# docker exec -it [CONTAINERID] bash
