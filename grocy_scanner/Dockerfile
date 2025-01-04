# Stage 1: Build the .NET application using Microsoft's SDK image
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copy application files
COPY ["GrocyScanner.Service/GrocyScanner.Service.csproj", "GrocyScanner.Service/"]
COPY ["GrocyScanner.Core/GrocyScanner.Core.csproj", "GrocyScanner.Core/"]
RUN dotnet restore "./GrocyScanner.Service/GrocyScanner.Service.csproj"

# Copy the rest of the source files and build the application
COPY . .
WORKDIR "/src/GrocyScanner.Service"
RUN dotnet publish "GrocyScanner.Service.csproj" -c Release -o /app/publish

# Stage 2: Use the Home Assistant base image to run the application
FROM homeassistant/amd64-base:3.18
WORKDIR /app

# Copy the published files from the build stage
COPY --from=build /app/publish .

# Copy the run.sh script
COPY grocy_scanner/run.sh /
RUN chmod a+x /run.sh

# Expose necessary ports
EXPOSE 9080 9443

# Set the entry point
ENTRYPOINT [ "/run.sh" ]
