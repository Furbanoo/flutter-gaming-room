import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gameroom/models/game.dart';
import 'package:gameroom/models/game_details.dart';
import 'package:http/http.dart';

const clientId = "nafqkzd8x0znec01vwi4yb5gegb8q5";
const clientSecret = "v2mdolwcszzt0okoo9bbvoiebrmkil";
const acessToken = "3cozrcua964em9y87u1otc7my8l0kl";

Future<Response> fetch(String endpoint, String query) async {
  Response response = await post(
    Uri.parse('https://api.igdb.com/v4/$endpoint'),
    headers: <String, String>{
      'Client-ID': clientId,
      'Authorization': 'Bearer $acessToken',
      'Accept': 'application/json',
    },
    body: query,
  );

  if (response.statusCode == 401) {
    getAccessToken();
  }

  return response;
}

Future<List<Game>> search(String query) async {
  Response response = await fetch("games",
      'fields name, cover.image_id, summary, total_rating, first_release_date; search "$query"; limit 20;');

  return List<Game>.from(
    jsonDecode(response.body).map(
      (game) => Game.fromMap(game),
    ),
  );
}

Future<ReleaseDateResult> gameReleaseCarousel() async {
  DateTime now = DateTime.now();
  int unixTimestamp = now.toUtc().millisecondsSinceEpoch ~/ 1000;
  Response response = await fetch('release_dates',
      'fields date, game.id, game.hypes ; where date > $unixTimestamp & human != "TBD" & status != (2,3) & game.hypes > 10; sort game.name asc; limit 7;');

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    final Set<int> uniqueGameIds = {};
    final Set<int> dateGame = {};

    for (var item in jsonData) {
      final gameData = item['game'];

      final gameId = gameData['id'];
      final dates = item['date'];
      if (gameId is int) {
        uniqueGameIds.add(gameId);
        dateGame.add(dates);
      }
    }

    return ReleaseDateResult(uniqueGameIds.toList(), dateGame.toList());
  } else {
    throw Exception('Falha ao buscar games do carousel');
  }
}

// 0 Últimos Lançamentos
// 1 Lançamentos Futuros
// 2 Jogos Melhores Avaliados
// 3 Jogos Mais Aguardados
Future<List<int>> getIdsGames(int page) async {
  String endpoint = '';
  String query = '';
  DateTime now = DateTime.now();
  int unixTimestamp = now.toUtc().millisecondsSinceEpoch ~/ 1000;
  if (page == 0) {
    endpoint = 'release_dates';
    query =
        'fields game.id; where human != "TBD" & date < $unixTimestamp & status != (1,3); sort date desc; limit 50;';
  } else if (page == 1) {
    endpoint = 'release_dates';
    query =
        'fields game.id; where human != "TBD" & date > $unixTimestamp & status != (1,3); sort date desc; limit 50;';
  } else if (page == 2) {
    endpoint = 'release_dates';
    query =
        'fields id, game.aggregated_rating, game.aggregated_rating_count, game.total_rating, game.total_rating_count; where game.aggregated_rating > 85 & game.total_rating_count > 50; limit 50;';
  } else if (page == 3) {
    endpoint = 'release_dates';
    query =
        'fields date, game.id, game.name, human; where date > 1696813077 & game.hypes > 10; limit 50;';
  }

  Response response = await fetch(endpoint, query);

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    final Set<int> uniqueGameIds = {};

    for (var item in jsonData) {
      final gameData = item['game'];

      final gameId = gameData['id'];
      if (gameId is int) {
        uniqueGameIds.add(gameId);
      }
    }

    return uniqueGameIds.toList();
  } else {
    throw Exception('Falha ao buscar jogos');
  }
}

Future<List<Game>> fetchGamesByIds(List<int> gameIds) async {
  final idString = gameIds.join(",");
  final response = await fetch("games",
      'fields name, cover.image_id, summary, total_rating, first_release_date; where id = ($idString); limit ${gameIds.length};');

  return List<Game>.from(
    jsonDecode(response.body).map(
      (game) => Game.fromMap(game),
    ),
  );
}

Future<List<Game>> fetchGamesByFranchise(List<int> gameIds) async {
  final idString = gameIds.join(",");
  final response = await fetch("franchises",
      'fields games.name, games.cover.image_id, games.summary, games.total_rating, games.first_release_date; where id = ($idString); limit ${gameIds.length};');

  print(response.body);
  return List<Game>.from(
    jsonDecode(response.body).map(
      (game) => Game.fromMap(game),
    ),
  );
}

Future<List<Game>> fetchGamesByIdsCarousel(List<int> gameIds) async {
  final idString = gameIds.join(",");
  final response = await fetch("games",
      'fields name, cover.image_id, summary, total_rating, first_release_date; where id = ($idString);');

  final List<dynamic> jsonData = jsonDecode(response.body);

  final Map<int, dynamic> gamesMap = {};

  for (var gameData in jsonData) {
    final gameId = gameData['id'];
    gamesMap[gameId] = gameData;
  }

  // Criar a lista de jogos ordenada com base nos IDs originais
  final List<Game> orderedGames = gameIds.map((id) {
    final gameData = gamesMap[id];
    return Game.fromMap(gameData);
  }).toList();

  return orderedGames;
}

Future<GameDetails> gameDetails(int id) async {
  Response response = await fetch("games",
      'fields artworks.image_id, cover.image_id, dlcs.cover.image_id, dlcs.name, first_release_date, franchises.id, game_modes.name, genres.name, language_supports.language.id, language_supports.language.name, language_supports.language_support_type.id, language_supports.language_support_type.name, involved_companies.company.logo.image_id, involved_companies.company.name, name, platforms.name, platforms.platform_logo.image_id, release_dates.date, screenshots.image_id, similar_games.cover.image_id, similar_games.name, status, storyline, summary, themes.name, total_rating, total_rating_count, url, videos.name, videos.video_id, websites.category, websites.url; where id = $id;');

  return GameDetails.fromMap(jsonDecode(response.body)[0]);
}

Future<void> getAccessToken() async {
  await post(
    Uri.parse(
        'https://id.twitch.tv/oauth2/token?client_id=$clientId&client_secret=$clientSecret&grant_type=client_credentials'),
  );
  debugPrint("Atualizar Acess Token ");
}

class ReleaseDateResult {
  final List<int> idGame;
  final List<int> dateGame;

  ReleaseDateResult(this.idGame, this.dateGame);
}
