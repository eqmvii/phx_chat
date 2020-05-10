# Postgres Troubleshooting

POOL_SIZE was set to 18 initially.

This turned into a huge problem with the hobby deb 20 connection limit: the app booted and took 18 of the connections.

Then when I tried to run the app in other contexts hitting the same DB, it maxed out.

Key was to set pool size low for the webapp AND for the local app so they could both fit under the wire.

= = = = background research = = = = =



from psql get active connections:

```
select count(*) from pg_stat_activity where pid <> pg_backend_pid() and usename = current_user;
```

That was maxed out... weird.

## Kill all

```
$ heroku pg:killall
Terminating connections for all credentials... done
```

## Nuke the web dynos, effectively turning it off

heroku ps:scale web=0
