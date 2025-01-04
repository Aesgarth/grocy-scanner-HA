# Stage 1: Build the .NET application
#FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
FROM homeassistant/amd64-base:3.18

WORKDIR /src
COPY ["GrocyScanner.Service/GrocyScanner.Service.csproj", "GrocyScanner.Service/"]
COPY ["GrocyScanner.Core/GrocyScanner.Core.csproj", "GrocyScanner.Core/"]
RUN dotnet restore "./GrocyScanner.Service/GrocyScanner.Service.csproj"

COPY . .
WORKDIR "/src/GrocyScanner.Service"
RUN dotnet publish "GrocyScanner.Service.csproj" -c Release -o /app/publish

# Stage 2: Use Home Assistant base image for runtime
FROM homeassistant/amd64-base:3.18
WORKDIR /app

# Copy the built application
COPY --from=build /app/publish .

# Copy the run.sh script
COPY grocy_scanner/run.sh /run.sh
RUN chmod +x /run.sh

# Expose necessary ports
EXPOSE 9080 9443

# Set entry point to run.sh
ENTRYPOINT [ "/run.sh" ]
