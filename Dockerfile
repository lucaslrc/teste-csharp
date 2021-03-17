FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["teste-csharp.csproj", "./"]
RUN dotnet restore "teste-csharp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "teste-csharp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "teste-csharp.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "teste-csharp.dll"]
