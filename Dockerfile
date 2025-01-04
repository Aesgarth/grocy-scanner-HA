# Base image for running the .NET app
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Base image for building the .NET app
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["GrocyScanner.Service/GrocyScanner.Service.csproj", "GrocyScanner.Service/"]
COPY ["GrocyScanner.Core/GrocyScanner.Core.csproj", "GrocyScanner.Core/"]
RUN dotnet restore "GrocyScanner.Service/GrocyScanner.Service.csproj"
COPY . .
WORKDIR "/src/GrocyScanner.Service"
RUN dotnet build "GrocyScanner.Service.csproj" -c Release -o /app/build

# Publish the .NET app
FROM build AS publish
RUN dotnet publish "GrocyScanner.Service.csproj" -c Release -o /app/publish

# Final runtime image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Add environment variables for configuration
ENV GROCY_API_KEY=default_api_key
ENV GROCY_URL=http://localhost

# Entry point for the application
ENTRYPOINT ["dotnet", "GrocyScanner.Service.dll"]
