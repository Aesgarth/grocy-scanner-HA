# Stage 1: Build the .NET application using Microsoft's .NET SDK image
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copy the project files and restore dependencies
COPY ["GrocyScanner.Service/GrocyScanner.Service.csproj", "GrocyScanner.Service/"]
COPY ["GrocyScanner.Core/GrocyScanner.Core.csproj", "GrocyScanner.Core/"]
RUN dotnet restore "./GrocyScanner.Service/GrocyScanner.Service.csproj"

# Copy the remaining source files and publish the application
COPY . .
WORKDIR "/src/GrocyScanner.Service"
RUN dotnet publish "GrocyScanner.Service.csproj" -c Release -o /app/publish

# Stage 2: Use the Home Assistant base image for runtime
FROM homeassistant/amd64-base:3.18
WORKDIR /app

# Copy the published files from the build stage
COPY --from=build /app/publish .

# Copy the run.sh script for Home Assistant S6 overlay compatibility
COPY run.sh /etc/services.d/grocy-scanner/run
RUN chmod +x /etc/services.d/grocy-scanner/run

# Expose necessary ports
EXPOSE 9080 9443
