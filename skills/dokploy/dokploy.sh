#!/bin/bash

# Dokploy API Helper Script
# Usage: ./dokploy.sh <command> [options]

DOKPLOY_URL="${DOKPLOY_URL:-}"
DOKPLOY_API_KEY="${DOKPLOY_API_KEY:-}"

usage() {
    echo "Dokploy API Helper"
    echo ""
    echo "Usage: $0 <command> [options]"
    echo ""
    echo "Commands:"
    echo "  list                       List all applications"
    echo "  search <query>             Search applications"
    echo "  get <app-id>               Get application details"
    echo "  deploy <app-id>            Deploy application"
    echo "  redeploy <app-id>          Redeploy application"
    echo "  start <app-id>             Start application"
    echo "  stop <app-id>              Stop application"
    echo "  delete <app-id>            Delete application"
    echo "  status <app-name>          Get application monitoring/status"
    echo ""
    echo "Environment Variables:"
    echo "  DOKPLOY_URL       Your Dokploy instance URL"
    echo "  DOKPLOY_API_KEY  Your API key"
    exit 1
}

check_config() {
    if [[ -z "$DOKPLOY_URL" || -z "$DOKPLOY_API_KEY" ]]; then
        echo "Error: DOKPLOY_URL and DOKPLOY_API_KEY must be set"
        exit 1
    fi
}

CMD="${1:-}"
shift || true

case "$CMD" in
    list)
        check_config
        curl -s -X GET "$DOKPLOY_URL/api/application.search" \
            -H "x-api-key: $DOKPLOY_API_KEY"
        ;;
    search)
        check_config
        Q="${1:-}"
        curl -s -X GET "$DOKPLOY_URL/api/application.search?q=$Q" \
            -H "x-api-key: $DOKPLOY_API_KEY"
        ;;
    get)
        check_config
        APP_ID="${1:-}"
        curl -s -X GET "$DOKPLOY_URL/api/application.one?applicationId=$APP_ID" \
            -H "x-api-key: $DOKPLOY_API_KEY"
        ;;
    deploy)
        check_config
        APP_ID="${1:-}"
        curl -s -X POST "$DOKPLOY_URL/api/application.deploy" \
            -H "Content-Type: application/json" \
            -H "x-api-key: $DOKPLOY_API_KEY" \
            -d "{\"applicationId\":\"$APP_ID\"}"
        ;;
    redeploy)
        check_config
        APP_ID="${1:-}"
        curl -s -X POST "$DOKPLOY_URL/api/application.redeploy" \
            -H "Content-Type: application/json" \
            -H "x-api-key: $DOKPLOY_API_KEY" \
            -d "{\"applicationId\":\"$APP_ID\"}"
        ;;
    start)
        check_config
        APP_ID="${1:-}"
        curl -s -X POST "$DOKPLOY_URL/api/application.start" \
            -H "Content-Type: application/json" \
            -H "x-api-key: $DOKPLOY_API_KEY" \
            -d "{\"applicationId\":\"$APP_ID\"}"
        ;;
    stop)
        check_config
        APP_ID="${1:-}"
        curl -s -X POST "$DOKPLOY_URL/api/application.stop" \
            -H "Content-Type: application/json" \
            -H "x-api-key: $DOKPLOY_API_KEY" \
            -d "{\"applicationId\":\"$APP_ID\"}"
        ;;
    delete)
        check_config
        APP_ID="${1:-}"
        curl -s -X POST "$DOKPLOY_URL/api/application.delete" \
            -H "Content-Type: application/json" \
            -H "x-api-key: $DOKPLOY_API_KEY" \
            -d "{\"applicationId\":\"$APP_ID\"}"
        ;;
    status)
        check_config
        APP_NAME="${1:-}"
        curl -s -X GET "$DOKPLOY_URL/api/application.readAppMonitoring?appName=$APP_NAME" \
            -H "x-api-key: $DOKPLOY_API_KEY"
        ;;
    *)
        usage
        ;;
esac
