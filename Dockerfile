FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /source

COPY *.sln .
COPY EncryptionApp.ApiGateway/*.csproj ./EncryptionApp.ApiGateway/
COPY EncryptionApp.EncryptionService/*.csproj ./EncryptionApp.EncryptionService/

RUN dotnet restore EncryptionApp

COPY . .
WORKDIR /source/EncryptionApp
RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "EncryptionApp.dll"]