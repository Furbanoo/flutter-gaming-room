import 'package:flutter/material.dart';
import 'package:gameroom/models/games.dart';
import 'package:gameroom/pages/game_page.dart';
import 'package:provider/provider.dart';

class GridGame extends StatelessWidget {
  const GridGame({
    super.key,
  });

  void _selectedGame(BuildContext context) {
    final games = Provider.of<Games>(
      context,
      listen: false,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GamePage(
          cover: games.cover,
          title: games.title,
          description: games.description,
          video: games.video,
          genres: games.genres,
          platform: games.platform,
          publisher: games.publisher,
          releaseDate: games.releaseDate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final games = Provider.of<Games>(context);
    return InkWell(
      onTap: () => _selectedGame(context),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              games.cover,
              height: 400,
              width: 400,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    games.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}