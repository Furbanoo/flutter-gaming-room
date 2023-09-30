import 'package:flutter/material.dart';
import 'package:gameroom/data/dummy_games.dart';
import 'package:gameroom/models/games.dart';

class GamesList with ChangeNotifier {
  final List<Games> _games = dummyGames;

  List<Games> get games => [..._games];

  void addGames(Games games) {
    _games.add(games);
    notifyListeners();
  }
}
