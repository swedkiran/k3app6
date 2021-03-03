FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["k3app6.csproj", "./"]
RUN dotnet restore "k3app6.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "k3app6.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "k3app6.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "k3app6.dll"]
