# appbase-docker-compose
Docker compose file to start a local appbase engine with its web-console

## How to use
Execute

```
sudo docker-compose up -d
```

(the first time it will build the tomcat image as well)

Check both postgres and tomcat7 containers are running

``` 
sudo docker-compose ps
```

You should get something like this

```
      Name                    Command               State                     Ports                   
------------------------------------------------------------------------------------------------------
appbase-postgres   /docker-entrypoint.sh postgres   Up      0.0.0.0:15432->5432/tcp,:::15432->5432/tcp
appbase-tomcat     catalina.sh run                  Up      0.0.0.0:18080->8080/tcp,:::18080->8080/tcp
```

Init the FQL metadata tables (ony on the first run)

```
sudo docker exec -i appbase-postgres psql appbase < ./fql_ddl.sql fql
```

You can access the web console locally on: http://localhost:18080/appbase-webconsole/

The data on the postgres db will be preserved under the `.postgres` folder, even after restarting the container.

Happy development!!!
