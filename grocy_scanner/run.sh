#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Grocy Scanner
# Starts the Grocy Scanner service
# ==============================================================================

# Load the add-on options
API_KEY=$(bashio::config 'api_key')
GROCY_URL=$(bashio::config 'grocy_url')

# Log the configuration
bashio::log.info "Starting Grocy Scanner with API Key: ${API_KEY} and URL: ${GROCY_URL}"

# Run the application
exec dotnet /app/GrocyScanner.Service.dll
