FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["ucp_umbraco.csproj", "./"]
RUN dotnet restore "ucp_umbraco.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet publish "ucp_umbraco.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "ucp_umbraco.dll"]