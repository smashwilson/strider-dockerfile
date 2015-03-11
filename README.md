# Strider

This is a Dockerfile that launches a StriderCD server configured to easily run page builds. There are other Strider Dockerfiles, but many of them (including the quasi-official one) bundle MongoDB, which feels like overkill.

To build and run this container, you must have access to a MongoDB as mentioned above.  If you have mongod running on your localhost, you can pass in the database string as an environment variable.  Starting from the root directory of this GitHub project:

```
$ docker build -t="strider" .
$ docker run -p 3000:3000 -d -e "DB_URI=mongodb://192.168.59.3/strider" --name strider
```

Note: your IP address may differ. If you are running docker from Linux, it should be your localhost. If you are running boot2docker, you can find your ip by running ```boot2docker config | grep HostIP```  Also, if you have a username and password setup for mongo, you can set your connection string to DB_URI=mongodb://user:password@192.168.59.3/strider

From here, you have a container running strider, connected to the database you specified.  You should be able to connect to it with your web browser.  Hint: Remember if you are using boot2docker that you must connect to your Linux VM's IP address, which can be found with ```boot2docker ip```

Unfortunately, if this is your first time running strider, that database has probably not been seeded with the admin user.  To seed your database, you can do this ugly hack:

```
$ docker run -i -t -e "DB_URI=mongodb://192.168.59.3/strider" --entrypoint="/bin/bash" strider
strider@9e16ad168acf:~$ node /home/strider/node_modules/.bin/strider addUser
Connecting to MongoDB URL: mongodb://192.168.59.3/strider

Enter email []: your-email@your-org.com
Is admin? (y/n) [n]y
Enter password []: ****

Email:		your-email@your-org.com
Password:	****
isAdmin:	y
OK? (y/n) [y]y

User added successfully! Enjoy.
strider@00000ca92151:~$ exit
```

Now you should be able to login to your strider instance with the email address and password you setup.

TODO: we need a better way to initialize the database.

This Dockerfile is also available from Docker Hub here: https://registry.hub.docker.com/u/deconst/strider/
