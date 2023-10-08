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
      'fields name, cover.image_id, summary, total_rating, first_release_date; search "$query"; where category = 0;');

  return List<Game>.from(
    jsonDecode(response.body).map(
      (game) => Game.fromMap(game),
    ),
  );
}

Future<List<int>> releaseOrComingGames(int query) async {
  String date;
  if (query == 0) {
    date = "<";
  } else {
    date = ">";
  }
  DateTime now = DateTime.now();
  int unixTimestamp = now.toUtc().millisecondsSinceEpoch ~/ 1000;
  Response response = await fetch('release_dates',
      'fields game.id; where human != "TBD" & date $date $unixTimestamp & status != (2,3); sort date desc; limit 50;');

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
    throw Exception('Falha ao buscar últimos lançamentos');
  }
}

Future<List<Game>> fetchGamesByIds(List<int> gameIds) async {
  final idString = gameIds.join(",");
  final response = await fetch("games",
      'fields name, cover.image_id, summary, total_rating, first_release_date; where id = ($idString); limit ${idString.length};');

  return List<Game>.from(
    jsonDecode(response.body).map(
      (game) => Game.fromMap(game),
    ),
  );
}

Future<List<Game>> fetchGames() async {
  Response response = await fetch("games",
      'fields name, cover.image_id; sort total_rating desc; limit 10;');

  return List<Game>.from(
    jsonDecode(response.body).map(
      (game) => Game.fromMap(game),
    ),
  );
}

Future<GameDetails> gameDetails(int id) async {
  Response response = await fetch("games",
      'fields artworks.image_id, genres.name, involved_companies.company.name, involved_companies.company.logo.image_id, platforms.name, platforms.platform_logo.image_id, screenshots.image_id, similar_games.name, similar_games.cover.image_id, cover.image_id, first_release_date, name, summary, total_rating, total_rating_count, status, storyline, themes.name, url, websites.url, websites.category, game_modes.name, videos.video_id, videos.name; where id = $id;');

  return GameDetails.fromMap(jsonDecode(response.body)[0]);
}

Future<void> getAccessToken() async {
  await post(
    Uri.parse(
        'https://id.twitch.tv/oauth2/token?client_id=$clientId&client_secret=$clientSecret&grant_type=client_credentials'),
  );
  debugPrint("Atualizar Acess Token ");
}
