import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gameroom/models/games.dart';
import 'package:gameroom/pages/game_page.dart';
import 'package:provider/provider.dart';

class ListGame extends StatelessWidget {
  const ListGame({super.key});

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
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
        child: Row(
          children: [
            Image.network(
              games.cover,
              width: 150,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    games.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  height: 150,
                  width: MediaQuery.of(context).size.width / 2,
                  child: AutoSizeText(
                    games.description,
                    maxLines: 10,
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
