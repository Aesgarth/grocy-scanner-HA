#!/usr/bin/with-contenv bashio

# Log add-on startup
bashio::log.info "Starting Grocy Scanner Add-on"

# Retrieve options from the configuration
API_KEY=$(bashio::config 'api_key')
GROCY_URL=$(bashio::config 'grocy_url')

# Log configuration
bashio::log.info "API Key: ${API_KEY}"
bashio::log.info "Grocy URL: ${GROCY_URL}"

# Start the .NET application
exec dotnet /app/GrocyScanner.Service.dll
