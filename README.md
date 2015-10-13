# Strider

[![Docker Repository on Quay.io](https://quay.io/repository/smashwilson/strider/status "Docker Repository on Quay.io")](https://quay.io/repository/smashwilson/strider)

This is a Dockerfile that launches a StriderCD server configured to easily run page builds. There are other Strider Dockerfiles, but many of them (including the quasi-official one) bundle MongoDB, which feels like overkill.

## Running Strider locally

To build and run this container, you'll first need to install:

 * [Docker](https://docs.docker.com/installation/#installation) to build and launch the container.
 * [docker-compose](https://docs.docker.com/compose/install/) to manage the container's configuration.

Now invoke docker-compose:

```bash
# Rebuild the image
docker-compose build

# Launch the strider and MongoDB containers as daemons.
docker-compose up -d
```

Strider is now running and connected to a MongoDB database running in another container. However, you won't be able to log in yet, because you don't have an admin user! To create one, follow the prompts when you run:

```bash
$ script/admin-user
Connecting to MongoDB URL: mongodb://mongo/strider

Enter email []: your-email@your-org.com
Is admin? (y/n) [n]y
Enter password []: ****

Email:		your-email@your-org.com
Password:	****
isAdmin:	y
OK? (y/n) [y]

User added successfully! Enjoy.
```

Visit port 3000 on the appropriate host to log in. :sparkles:

**Note:** If you're running Docker through boot2docker or docker-machine (on a Mac or Windows), the URL you'll use to connect will *not* be http://localhost:3000/. You'll need to locate the IP address of the boot2docker VM with `boot2docker ip` and connect to port 3000 on that host instead.
