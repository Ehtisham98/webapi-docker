# Use .NET 8.0 SDK base image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set working directory
WORKDIR /app

# Copy the project files
COPY *.csproj ./

# Restore dependencies
RUN dotnet restore

# Copy the remaining files and publish the app
COPY . ./
RUN dotnet publish -c Release -o out

# Use the .NET runtime to create the final image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "WEBAPI.dll"]
