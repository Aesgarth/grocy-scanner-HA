# Use the Home Assistant base image
FROM homeassistant/amd64-base:3.18

# Copy application files
WORKDIR /app
COPY GrocyScanner.Service/ ./GrocyScanner.Service/
COPY GrocyScanner.Core/ ./GrocyScanner.Core/
COPY GrocyScanner.sln ./

# Install .NET dependencies and build the application
RUN apk add --no-cache dotnet-sdk \
 && dotnet restore ./GrocyScanner.Service/GrocyScanner.Service.csproj \
 && dotnet build ./GrocyScanner.Service/GrocyScanner.Service.csproj -c Release -o /app/build \
 && dotnet publish ./GrocyScanner.Service/GrocyScanner.Service.csproj -c Release -o /app/publish

# Copy add-on configuration files
COPY grocy_scanner/run.sh /
RUN chmod a+x /run.sh

# Expose necessary ports
EXPOSE 9080 9443

# Set entry point
ENTRYPOINT [ "/run.sh" ]
