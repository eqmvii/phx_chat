docker inspecting postgres container

  "Mounts": [
      {
          "Type": "volume",
          "Name": "491edd28413c414dcfbab89e91e9d081c98b6598b435298d99e2ed7266067d9a",
          "Source": "/var/lib/docker/volumes/491edd28413c414dcfbab89e91e9d081c98b6598b435298d99e2ed7266067d9a/_data",
          "Destination": "/var/lib/postgresql/data",
          "Driver": "local",
          "Mode": "",
          "RW": true,
          "Propagation": ""
      }
  ],

# stopped then started contaier:

        "Mounts": [
            {
                "Type": "volume",
                "Name": "0a12f13d4761b8c217dd79b1e1024c6983736adcee3e4b9af0e2adf0a66e50d4",
                "Source": "/var/lib/docker/volumes/0a12f13d4761b8c217dd79b1e1024c6983736adcee3e4b9af0e2adf0a66e50d4/_data",
                "Destination": "/var/lib/postgresql/data",
                "Driver": "local",
                "Mode": "",
                "RW": true,
                "Propagation": ""
            }
        ],

# what if I create and name it myself

$ docker volume inspect phx_chat_pg_data
[
    {
        "CreatedAt": "2020-05-03T04:29:57Z",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/phx_chat_pg_data/_data",
        "Name": "phx_chat_pg_data",
        "Options": {},
        "Scope": "local"
    }
]


# Now with better naming:

        "Mounts": [
            {
                "Type": "volume",
                "Name": "phx_chat_phx_chat_pg_data",
                "Source": "/var/lib/docker/volumes/phx_chat_phx_chat_pg_data/_data",
                "Destination": "/var/lib/postgresql/data",
                "Driver": "local",
                "Mode": "rw",
                "RW": true,
                "Propagation": ""
            }
        ],

        "Mounts": [
            {
                "Type": "volume",
                "Name": "phx_chat_phx_chat_pg_data",
                "Source": "/var/lib/docker/volumes/phx_chat_phx_chat_pg_data/_data",
                "Destination": "/var/lib/postgresql/data",
                "Driver": "local",
                "Mode": "rw",
                "RW": true,
                "Propagation": ""
            }
        ],
