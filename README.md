# Drone CI vs Jenkins: Demo

Demo to compare the set up in Drone CI and Jenkins.

## Set up

### Create an OAuth App
Go to `GitHub > Settings > Developer settings > New OAuth App`:

![Create OAuth app on GitHub](create-oauth-app-github.png)

Now, get the OAuth credentials:

![OAuth credentials](get-secrets-from-oauth-app.png)

### Add credentials to environment variables
Set environment variables in `.env`:

```bash
JENKINS_PORT=xxxx
DRONE_PORT=yyyy
DRONE_ADMIN=some,admins
DRONE_HOST=<schema>://<dronehost>
DRONE_GITHUB_CLIENT=ea3ob2f38ba79a2123
DRONE_GITHUB_SECRET=ea3ob2f38ba79a2123ea3ob2f38ba79a2123
DRONE_SECRET=somesecretstring
```

### Route traffic
You should also configure your servers such that triffic from `localhost:xxxx` goes to `<schema>://<jenkinshost>` and traffic from `localhost:yyyy` goes to `<schema>://<dronehost>`.

Now run:

```bash
docker-compose up -d
```

### Configure Drone CI
Go to your Drone CI host and register with your GitHub account. Select the GitHub project you want to listen to. When you have configured the `.drone.yml`-file, everything on the Drone CI part is done.

### Configure Jenkins
To configure Jenkins, go to your Jenkins host and use the password provided from the `docker-compose logs jenkins` to login. Configure your Jenkins and install the plugins you want. This can take a while. After configuration, make a `job` from the front page. Set a name to the job and make it a `Freestyle project`. Now set the job to use Git as Source Code Management and set Repository URL to an HTTPS-URL (To avoid SSH-keys. We only want to pull the repo for this demo). Add a build step in the Build section. Select `Execute shell` and write some commands like `$ echo Testing` to see if the job does something.

### Make Drone CI start a Jenkins job
Drone CI has a plugin called `Jenkins`, that sends a request to execute a job on a Jenkins server. To use this in drone, add this to the `.drone.yml`:

```diff
pipeline:
  ...
+ poke-jenkins:
+   image: appleboy/drone-jenkins
+   secrets: [ jenkins_url, jenkins_user, jenkins_token, jenkins_job ]
```

You also need to add some secrets to the Drone CI server. Go to the project > select the hamburger menu > secrets. Now add these variables:

- jenkins_url = `<schema>://<jenkinshost>`
- jenkins_user = admin-id (Found by clicking the user > configure > Show API Token)
- jenkins_token = API token (Found by clicking the user > configure > Show API Token)
- jenkins_job = what-you-called-the-job
