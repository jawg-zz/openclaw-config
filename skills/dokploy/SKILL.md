# dokploy - Deploy applications to Dokploy

Deploy and manage applications on your Dokploy self-hosted PaaS via its REST API.

## Setup

Store your Dokploy credentials in `TOOLS.md`:

```markdown
### Dokploy

- **url**: https://main.spidmax.win
- **api_key**: YOUR-API-KEY (generate at /settings/profile → API/CLI Section)
```

## Authentication

All API requests require the `x-api-key` header:

```bash
curl -X GET "https://your-dokploy.com/api/project.all" \
  -H "x-api-key: YOUR-API-KEY"
```

## Base URL

```bash
DOKPLOY_URL="https://main.spidmax.win"
API_KEY="your-api-key"
```

---

## Projects

### List Projects

```bash
curl -s -X GET "$DOKPLOY_URL/api/project.all" -H "x-api-key: $API_KEY"
```

### Get Project

```bash
curl -s -X GET "$DOKPLOY_URL/api/project.one?projectId=PROJECT_ID" -H "x-api-key: $API_KEY"
```

---

## Environments

### List Environments

```bash
curl -s -X GET "$DOKPLOY_URL/api/environment.all?projectId=PROJECT_ID" -H "x-api-key: $API_KEY"
```

---

## Applications

### Create Application

```bash
curl -s -X POST "$DOKPLOY_URL/api/application.create" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "name": "my-app",
    "environmentId": "ENVIRONMENT_ID"
  }'
```

### Get Application Details

```bash
curl -s -X GET "$DOKPLOY_URL/api/application.one?applicationId=APP_ID" -H "x-api-key: $API_KEY"
```

### Search Applications

```bash
curl -s -X GET "$DOKPLOY_URL/api/application.search?q=myapp" -H "x-api-key: $API_KEY"
```

### Update Application

```bash
curl -s -X POST "$DOKPLOY_URL/api/application.update" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "applicationId": "APP_ID",
    "name": "new-name"
  }'
```

### Deploy Application

```bash
curl -s -X POST "$DOKPLOY_URL/api/application.deploy" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{"applicationId": "APP_ID"}'
```

### Redeploy Application

```bash
curl -s -X POST "$DOKPLOY_URL/api/application.redeploy" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{"applicationId": "APP_ID"}'
```

### Start Application

```bash
curl -s -X POST "$DOKPLOY_URL/api/application.start" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{"applicationId": "APP_ID"}'
```

### Stop Application

```bash
curl -s -X POST "$DOKPLOY_URL/api/application.stop" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{"applicationId": "APP_ID"}'
```

### Delete Application

```bash
curl -s -X POST "$DOKPLOY_URL/api/application.delete" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{"applicationId": "APP_ID"}'
```

### Update Environment Variables

```bash
curl -s -X POST "$DOKPLOY_URL/api/application.saveEnvironment" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "applicationId": "APP_ID",
    "env": "NODE_ENV=production\nDB_HOST=localhost",
    "createEnvFile": true
  }'
```

### Get Application Monitoring

```bash
curl -s -X GET "$DOKPLOY_URL/api/application.readAppMonitoring?appName=APP_NAME" -H "x-api-key: $API_KEY"
```

---

## Compose (Docker Compose)

### Create Compose

```bash
curl -s -X POST "$DOKPLOY_URL/api/compose.create" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "name": "my-compose",
    "environmentId": "ENVIRONMENT_ID",
    "composeType": "docker-compose"
  }'
```

### Get Compose Details

```bash
curl -s -X GET "$DOKPLOY_URL/api/compose.one?composeId=COMPOSE_ID" -H "x-api-key: $API_KEY"
```

### Update Compose (including docker-compose.yml)

```bash
curl -s -X POST "$DOKPLOY_URL/api/compose.update" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "composeId": "COMPOSE_ID",
    "composeFile": "version: \"3.8\"\nservices:\n  web:\n    image: nginx:alpine\n    ports:\n      - \"8080:80\""
  }'
```

### Deploy Compose

```bash
curl -s -X POST "$DOKPLOY_URL/api/compose.deploy" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{"composeId": "COMPOSE_ID"}'
```

### Redeploy Compose

```bash
curl -s -X POST "$DOKPLOY_URL/api/compose.redeploy" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{"composeId": "COMPOSE_ID"}'
```

### Start Compose

```bash
curl -s -X POST "$DOKPLOY_URL/api/compose.start" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{"composeId": "COMPOSE_ID"}'
```

### Stop Compose

```bash
curl -s -X POST "$DOKPLOY_URL/api/compose.stop" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{"composeId": "COMPOSE_ID"}'
```

### Delete Compose

```bash
curl -s -X POST "$DOKPLOY_URL/api/compose.delete" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{"composeId": "COMPOSE_ID", "deleteVolumes": false}'
```

### Search Compose

```bash
curl -s -X GET "$DOKPLOY_URL/api/compose.search?q=mycompose" -H "x-api-key: $API_KEY"
```

---

## Source Types

When updating an application or compose, you can set different source types:

### GitHub (Recommended for Private Repos)

For private repositories, use the dedicated `application.saveGithubProvider` endpoint with your GitHub provider ID:

```bash
# First, get your GitHub provider ID:
curl -s -X GET "$DOKPLOY_URL/api/github.githubProviders" -H "x-api-key: $API_KEY"
# Returns: {"githubId":"xxx","gitProvider":{...}}

# Then use application.saveGithubProvider (NOT application.update):
curl -s -X POST "$DOKPLOY_URL/api/application.saveGithubProvider" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "applicationId": "APP_ID",
    "repository": "owner/repo",
    "owner": "owner",
    "branch": "main",
    "buildPath": ".",
    "githubId": "GITHUB_PROVIDER_ID",
    "watchPaths": [],
    "enableSubmodules": false
  }'
```

**Why this works:** The GitHub provider ID links your authorized GitHub App installation which has access to private repos.

### GitLab

```bash
curl -s -X POST "$DOKPLOY_URL/api/application.update" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "applicationId": "APP_ID",
    "sourceType": "gitlab",
    "gitlabRepository": "owner/repo",
    "gitlabBranch": "main"
  }'
```

### Docker Image

```bash
curl -s -X POST "$DOKPLOY_URL/api/application.update" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "applicationId": "APP_ID",
    "sourceType": "docker",
    "dockerImage": "nginx:alpine"
  }'
```

### Raw (docker-compose.yml directly)

```bash
curl -s -X POST "$DOKPLOY_URL/api/compose.update" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "composeId": "COMPOSE_ID",
    "sourceType": "raw",
    "composeFile": "version: \"3.8\"\nservices:\n  web:\n    image: nginx:alpine"
  }'
```

---

## Domains

### Create Domain (for Application)

```bash
curl -s -X POST "$DOKPLOY_URL/api/domain.create" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "host": "app.yourdomain.com",
    "https": true,
    "applicationId": "APP_ID",
    "domainType": "application"
  }'
```

### Create Domain (for Compose Service)

⚠️ **IMPORTANT:** You must use the HOST port (first number), NOT the container port!

```yaml
# docker-compose.yml
services:
  web:
    ports:
      - "8080:80"   # <-- Use 8080 (host), not 80 (container)!
```

```bash
curl -s -X POST "$DOKPLOY_URL/api/domain.create" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "host": "app.yourdomain.com",
    "https": true,
    "port": 8080,
    "composeId": "COMPOSE_ID",
    "serviceName": "web",
    "domainType": "compose"
  }'
```

### Update Domain

```bash
curl -s -X POST "$DOKPLOY_URL/api/domain.update" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "domainId": "DOMAIN_ID",
    "host": "newdomain.yourdomain.com",
    "https": true
  }'
```

### Delete Domain

```bash
curl -s -X POST "$DOKPLOY_URL/api/domain.delete" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{"domainId": "DOMAIN_ID"}'
```

---

## ⚠️ CRITICAL: Application Port Configuration

For Applications (not Compose), the port is controlled by `previewPort`:
- Default: 3000
- The app runs on this port inside Docker
- When creating a domain, use the **same port** as previewPort

Example - changing port to 8080:
```bash
curl -s -X POST "$DOKPLOY_URL/api/application.update" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "applicationId": "APP_ID",
    "previewPort": 8080
  }'
```

Then create domain with that port:
```bash
curl -s -X POST "$DOKPLOY_URL/api/domain.create" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "host": "app.yourdomain.com",
    "https": true,
    "port": 8080,
    "applicationId": "APP_ID",
    "domainType": "application"
  }'
```

---

## ⚠️ CRITICAL: Getting the Correct Port for Domains

When creating a domain for a compose service, you MUST look up the actual port from the compose configuration:

### Step 1: Get Compose Details

```bash
curl -s -X GET "$DOKPLOY_URL/api/compose.one?composeId=COMPOSE_ID" -H "x-api-key: $API_KEY"
```

### Step 2: Find the ports mapping

Look at the `composeFile` field. The format is:
- `"ports:"` → `"HOST_PORT:CONTAINER_PORT"`

Example from docker-compose.yml:
```yaml
services:
  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    ports:
      - "8081:80"   # <-- HOST:CONTAINER
```

### Step 3: Use the HOST port (first number!)

- ✅ Correct: `port: 8081` (the host port)
- ❌ Wrong: `port: 80` (the container port - will cause 502 error)

For the example above:
```bash
curl -s -X POST "$DOKPLOY_URL/api/domain.create" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "host": "pma.yourdomain.com",
    "https": true,
    "port": 8081,        # <-- Use 8081, NOT 80!
    "composeId": "COMPOSE_ID",
    "serviceName": "phpmyadmin",
    "domainType": "compose"
  }'
```

---

## Databases

### Create MySQL

```bash
curl -s -X POST "$DOKPLOY_URL/api/mysql.create" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "name": "mydb",
    "environmentId": "ENVIRONMENT_ID",
    "databaseName": "mydb",
    "databaseUser": "user",
    "databasePassword": "password",
    "dockerImage": "mysql:8"
  }'
```

### Create PostgreSQL

```bash
curl -s -X POST "$DOKPLOY_URL/api/postgres.create" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "name": "mydb",
    "environmentId": "ENVIRONMENT_ID",
    "databaseName": "mydb",
    "databaseUser": "user",
    "databasePassword": "password",
    "dockerImage": "postgres:16"
  }'
```

### Create MongoDB

```bash
curl -s -X POST "$DOKPLOY_URL/api/mongo.create" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "name": "mydb",
    "environmentId": "ENVIRONMENT_ID",
    "databaseName": "mydb",
    "databaseUser": "user",
    "databasePassword": "password",
    "dockerImage": "mongo:7"
  }'
```

### Create Redis

```bash
curl -s -X POST "$DOKPLOY_URL/api/redis.create" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $API_KEY" \
  -d '{
    "name": "myredis",
    "environmentId": "ENVIRONMENT_ID",
    "databasePassword": "password",
    "dockerImage": "redis:7"
  }'
```

---

## Deployment Status

### Get Deployment Logs

```bash
curl -s -X GET "$DOKPLOY_URL/api/deployment.log?deploymentId=DEPLOYMENT_ID" -H "x-api-key: $API_KEY"
```

---

## Common Workflows

### Full Deploy Flow (Application)

1. Create application or get existing `applicationId`
2. Set build type (dockerfile, etc.)
3. Connect git provider (GitHub, GitLab, etc.)
4. Set environment variables
5. Deploy
6. Check status via monitoring

### Full Deploy Flow (Compose)

1. Create compose or get existing `composeId`
2. Set `sourceType` (github, gitlab, raw, etc.)
3. If raw: set `composeFile` with docker-compose.yml content
4. If git: set repository, branch, composePath
5. Set environment variables via `env` field
6. Deploy
7. Check status

### Restart Application/Compose

1. Stop the application/compose
2. Start the application/compose

---

## Troubleshooting

### Check Deployment Status

After deploying, check the status:

```bash
curl -s -X GET "$DOKPLOY_URL/api/compose.one?composeId=COMPOSE_ID" -H "x-api-key: $API_KEY" | grep -o '"composeStatus":"[^"]*"'
```

Status values: `idle`, `running`, `done`, `error`

### View Latest Deployment

```bash
curl -s -X GET "$DOKPLOY_URL/api/compose.one?composeId=COMPOSE_ID" -H "x-api-key: $API_KEY"
# Look at the last item in the "deployments" array
```

### Check Application Logs

```bash
curl -s -X GET "$DOKPLOY_URL/api/deployment.log?deploymentId=DEPLOYMENT_ID" -H "x-api-key: $API_KEY"
```
