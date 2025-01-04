#!/usr/bin/with-contenv bashio

# Log add-on startup
bashio::log.info "Starting Grocy Scanner Add-on"

# Retrieve options from config.yaml
API_KEY=$(bashio::config 'api_key')
GROCY_URL=$(bashio::config 'grocy_url')

# Log configuration values (optional, redact sensitive info in production)
bashio::log.info "Using API Key: ${API_KEY}"
bashio::log.info "Grocy URL: ${GROCY_URL}"

# Run the .NET application
exec dotnet GrocyScanner.Service.dll
