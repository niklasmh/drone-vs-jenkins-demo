# Drone CI vs Jenkins: Demo

Demo to compare the set up in Drone CI and Jenkins.

## Set up

Create an OAuth App on `GitHub > Settings > Developer settings > New OAuth App`:

![Create OAuth app on GitHub](create-oauth-app-github.png)

Now, get then OAuth credentials:

![OAuth credentials](get-secrets-from-oauth-app.png)

Set environment variables in `.env`:

```
JENKINS_PORT=xxxx
JENKINS_HOST=<schema>://<jenkinshost>
JENKINS_USER=root
JENKINS_TOKEN=sometoken
DRONE_PORT=yyyy
DRONE_ADMIN=some,admins
DRONE_HOST=<schema>://<dronehost>
DRONE_GITHUB_CLIENT=ea3ob2f38ba79a2123
DRONE_GITHUB_SECRET=ea3ob2f38ba79a2123ea3ob2f38ba79a2123
DRONE_SECRET=somesecretstring
```

You should also configure your servers such that triffic from `localhost:xxxx` goes to `<schema>://<jenkinshost>` and traffic from `localhost:yyyy` goes to `<schema>://<dronehost>`.

Now run:

```bash
docker-compose up -d
```
