### Read how to create a minimal self-hosted version of Omnivore

Omnivore is a free and open-source read-it-later service for people that love to read. All of the source code for the backend, web frontend, and mobile apps is available at <https://github.com/omnivore-app/omnivore>. 

## In this tutorial 

We will setup a minimal self-hosted version of Omnivore. We will use [fly.io](https://fly.io/), a popular edge hosting platform that supports Docker and has built-in PostgreSQL support. We will also use [bonsai.io](https://bonsai.io/) an Elasticsearch hosting platform with a minimal free tier.

The purpose of this tutorial is to get the easiest possible install experience and understand the architecture enough to deploy on other platforms. To do that, we wont enable all of Omnivore’s features, and we will take advantage of some cloud services. In future tutorials we will setup more of Omnivore’s features and deploy to different platforms. The goal of this tutorial is to get a minimal setup and connect the iOS app.

## What’s not in this tutorial

The following Omnivore features will not be included in this minimal Omnivore setup: 

* The web app (we will use the iOS app from the AppStore as our client)
* Search of PDFs
* Saving URLs instead of pages (more on this below)
* Receiving newsletters via email
* Text to speech

## Challenges

Omnivore has a [docker-compose file](https://github.com/omnivore-app/omnivore/blob/main/docker-compose.yml) that will form the basis of our self-hosted deployment. For this minimal sample we will use it as a guide, but only deploy the \`api\`, and \`migrate\` services, and then use fly.io’s PostgreSQL support, and bonsai.io’s Elasticsearch support for our storage.

The main challenge will be initial database configuration, and running our initial migrations.

## Setting up a docker container to run the API

The first thing we are going to do is copy the [Dockerfile](https://github.com/omnivore-app/omnivore/blob/main/self-hosting/Dockerfile) and [selfhost.sh](https://github.com/omnivore-app/omnivore/blob/main/self-hosting/selfhost.sh) file from the the self-hosting directory to our root directory. This is a slightly modified version of the Dockerfile in packages/api/. 

In this Dockerfile we’ve included packages/db and the selfhost.sh script. This is done so the main api server can run its setup and migrations on startup.

[![](https://proxy-prod.omnivore-image-cache.app/1456x1473,siDGtEfi5WwCTD7cZTpjN3ln9LGNrMDv3oEaKneSFUrE/https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fcb114cec-c693-47c8-aa19-6a658406bc3b_2052x2076.png)](https://substackcdn.com/image/fetch/f%5Fauto,q%5Fauto:good,fl%5Fprogressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fcb114cec-c693-47c8-aa19-6a658406bc3b%5F2052x2076.png)

You should be able to run \`docker build .\` now in the root directory to build the docker image.

## Launching the API on fly.io

### Setup a fly.io account and install flyctl

Follow the instructions at [https://fly.io](https://fly.io/) to setup your account and install the flyctl command. Make sure to go into your fly.io settings and set up two factor authentication.

### Run flyctl launch

In the root source directory run \`flyctl launch\`. This will walk you through the process of creating a flyctl app for the Dockerfile we just copied to this directory.

During the flyctl launch process you will be asked to create a PostgreSQL database (say yes) and a Redis cluster (say No). Make sure to take note of the \`DATABASE\_URL\` printed after the PostgreSQL database is created.

### Set the database environment variables and secrets

When flyctl created our PostgreSQL database it set the DATABASE\_URL secret. Omnivore does not use DATABASE\_URL but we will use this value to set Omnivore’s database environment variables.

We will set the following variables:

```pgsql
PG_HOST = // the host from DATABASE_URL (eg "omnivore-api-db.internal")

POSTGRES_USER = // the username from DATABASE_URL (eg omnivore_api) we will use this to run migrations and initial DB set

POSTGRES_PASSWORD = // the password from the DATABASE_URL will use this to run migrations and initial DB set

PG_USER = "app_user"
PG_PASSWORD = // we will generate a unique password
PG_DB = "omnivore"
PG_PORT = "5432"
PG_POOL_MAX = "20"
```

First we will set the values that don’t need to be stored as secrets. When we launched the service, flyctl created a fly.toml file in the root source directory. Add the following text to the bottom of the file. These values will be set in the services environment when it is started. 

```pgsql
[env]
  API_ENV = "local"
  PG_HOST = "omnivore-api-db.internal" // from DATABASE_URL
  PG_DB = "omnivore"
  PG_PORT = "5432"
  PG_USER = "app_user"
  PG_POOL_MAX = "20"
  JAEGER_HOST = "jaeger"
  CLIENT_URL = "http://localhost:3000"
  GATEWAY_URL = "http://localhost:8080/api"
  REMINDER_TASK_HANDLER_URL = "/svc/reminders/trigger"
```

 To set the database password values first find the password part of the DATABASE\_URL. When we set PG\_PASSWORD, we will also set POSTGRES\_PASSWORD, this variable is used to run the database migrations on startup. We can set them both at the same time with \`flyctl secrets\`

```pgsql
flyctl secrets -a omnivore-api set POSTGRES_PASSWORD=<the password value from DATABASE_URL> PG_PASSWORD=<the unique password we generated>
```

### Setting up Elasticsearch on bonsai.io

Go to <https://bonsai.io/> and sign up for a free account. This will provision a small elastic cluster for you. Once your cluster is provisioned, go to the ACCESS section, and click on Credentials. You should see a Full Access URL. 

Similar to what we did with DATABASE\_URL we will want to parse this Elasticsearch URL and set the variables: ELASTIC\_URL, ELASTIC\_USERNAME, and ELASTIC\_PASSWORD.

You can remove the username/password portion of the URL and set it at the bottom of the \`\[env\]\` section, this is what our updated fly.toml env section looks like:

```pgsql
[env]
  API_ENV = "local"
  PG_HOST = "omnivore-api-db.internal" // from DATABASE_URL
  PG_DB = "omnivore"
  PG_PORT = "5432"
  PG_USER = "app_user"
  PG_POOL_MAX = "20"
  JAEGER_HOST = "jaeger"
  CLIENT_URL = "http://localhost:3000"
  GATEWAY_URL = "http://localhost:8080/api"
  REMINDER_TASK_HANDLER_URL = "/svc/reminders/trigger"
  ELASTIC_URL = "https://omnivore-elastic-<id number>.us-east-1.bonsaisearch.net:443"
```

`Now run flyctl secrets to set the Elasticsearch user and password:`

```routeros
flyctl secrets -a omnivore-api set ELASTIC_USERNAME=<the username> ELASTIC_PASSWORD=<the password>
```

### Setting the JWT\_SECRET and restarting the service

The JWT\_SECRET is used for authenticating our web requests. We need to set this to a unique value. Here I used the `uuidgen` command to generate a unique value and set the JWT\_SECRET value.

```routeros
$ uuidgen
D4C4CBB1-3635-4FA1-A786-AFBE92D925D9
$flyctl secrets set JWT_SECRET=D4C4CBB1-3635-4FA1-A786-AFBE92D925D9
```

We also need to set the SSO\_JWT\_SECRET. This is for communication between the web frontend and the backend, we wont be using it in this deployment, but the api server expects it, and will not startup if it is not set:

```angelscript
$ uuidgen
5AEC327E-883A-474B-83A5-C5518EC56F83
$ flyctl secrets set SSO_JWT_SECRET=5AEC327E-883A-474B-83A5-C5518EC56F83
```

Finally we can deploy all of our environment changes

```gams
$flyctl deploy
```

### Verifying the API Deployment

  
When flyctl finishing deploying your app, it will print the apps URL, you can append \`/api/graphql\` to this URL and open it in your browser to verify the GraphQL server is running

[![](https://proxy-prod.omnivore-image-cache.app/536x0,sg-l5h1ZPq_UQ9hT7VxdFUONXcnp86VxzsFnMGqeHtHY/https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fdd998261-3366-4c3a-b689-e1f7607a0656_1892x1334.png)](https://substackcdn.com/image/fetch/f%5Fauto,q%5Fauto:good,fl%5Fprogressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fdd998261-3366-4c3a-b689-e1f7607a0656%5F1892x1334.png)

### Logging in on iOS, creating a user

In the iOS app there is a “self-hosting options” link at the bottom of the login screen, tap this link and enter your API server base URL (dont add the /api/graphql part to this URL)

[![](https://proxy-prod.omnivore-image-cache.app/250x0,sg29csqRsFQr_pT6YqKTMG1hqxE2Z9F7x893DnbBCBik/https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F9f76a073-e6dd-46b6-b11d-9f5d5a96a55a_1146x2158.png)](https://substackcdn.com/image/fetch/f%5Fauto,q%5Fauto:good,fl%5Fprogressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F9f76a073-e6dd-46b6-b11d-9f5d5a96a55a%5F1146x2158.png)

The other values will not be used for this deployment, but need to be filled in. Just put https://omnivore.app in both fields.

[![](https://proxy-prod.omnivore-image-cache.app/306x0,sC71uVOegqiINEtqITO4sxKFsn7LY3UN0i-sOJ7py0HQ/https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F417c5bd5-62c0-463b-964e-91912bd47840_1146x2158.png)](https://substackcdn.com/image/fetch/f%5Fauto,q%5Fauto:good,fl%5Fprogressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F417c5bd5-62c0-463b-964e-91912bd47840%5F1146x2158.png)

After you have filled in those fields click save. The app will be stopped. Re-open the app, and choose “Continue with Email”, then “Don’t have an account”, and sign up for a new account.

### Verifying your new account email

Because we haven’t set up an email sender, you wont be sent your account verification email. To work around this, we need to manually verify the account.

Run \`flyctl logs\` and look for a line like this:

```angelscript
2023-05-09T07:18:15Z app[6e82d95ecedd87] sin [info]Sending email: {
2023-05-09T07:18:15Z app[6e82d95ecedd87] sin [info]  from: '',
2023-05-09T07:18:15Z app[6e82d95ecedd87] sin [info]  to: 'jacksonh@gmail.com',
2023-05-09T07:18:15Z app[6e82d95ecedd87] sin [info]  templateId: '',
2023-05-09T07:18:15Z app[6e82d95ecedd87] sin [info]  dynamicTemplateData: {
2023-05-09T07:18:15Z app[6e82d95ecedd87] sin [info]    name: 'Jackson',
2023-05-09T07:18:15Z app[6e82d95ecedd87] sin [info]    link: 'http://localhost:3000/auth/confirm-email/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhNzQyZGU4ZS1lZTM5LTExZWQtODg3Yy05NzdmOTZmZDNkMjQiLCJpYXQiOjE2ODM2MTY2OTUsImV4cCI6MTY4MzcwMzA5NX0.msBAc9khna_CCARdhh67t_s1nxcfA6zIXuVkq-7M1HA'
2023-05-09T07:18:15Z app[6e82d95ecedd87] sin [info]  }
```

Copy the token part of the link ( eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhNzQyZGU4ZS1lZTM5LTExZWQtODg3Yy05NzdmOTZmZDNkMjQiLCJpYXQiOjE2ODM2MTY2OTUsImV4cCI6MTY4MzcwMzA5NX0.msBAc9khna\_CCARdhh67t\_s1nxcfA6zIXuVkq-7M1HA` in the above example), and then construct a curl request like this:`

```awk
curl -d "token=<the token>" https://<your server base url>/api/auth/confirm-email/
```

for example:

```awk
curl -d "token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhNzQyZGU4ZS1lZTM5LTExZWQtODg3Yy05NzdmOTZmZDNkMjQiLCJpYXQiOjE2ODM2MTY2OTUsImV4cCI6MTY4MzcwMzA5NX0.msBAc9khna_CCARdhh67t_s1nxcfA6zIXuVkq-7M1HA" https://omnivore-api.fly.dev/api/auth/confirm-email/
```

### Saving URLs

The \`content-fetch\` service is used for saving URLs. This service runs a puppeteer service that downloads web content. For simplicity we did not include this service in the tutorial. The iOS app and browser extensions are capable of scraping content, so URL saving isn’t needed. The Android client, and the Web’s Add Link button require the content-fetch service.

### Wrapping Up

We created this tutorial to give people an idea of the issues they’d encounter when setting up a self-hosted instance of Omnivore and to give ourselves a better understanding of how we can make self-hosting easier.

The main issues you will hit when self hosting are: setting up the database and running migrations, setting your environment variables, and verifying your initial user.

If you are trying to self-host your own instance of Omnivore, please [join us on Discord](https://discord.gg/h2z5rppzz9), let us know where you are deploying, and how we can make things easier.