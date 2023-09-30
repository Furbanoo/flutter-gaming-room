import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gameroom/models/games.dart';
import 'package:gameroom/pages/game_page.dart';
import 'package:provider/provider.dart';

class SearchGame extends StatefulWidget {
  const SearchGame({super.key});

  @override
  State<SearchGame> createState() => _SearchGameState();
}

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

class _SearchGameState extends State<SearchGame> {
  @override
  Widget build(BuildContext context) {
    final games = Provider.of<Games>(context);
    return InkWell(
      onTap: () => _selectedGame(context),
      child: Container(
        margin: const EdgeInsets.only(left: 10.0, bottom: 20.0),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Image.network(
                games.cover,
                width: 100,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    games.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Data de Lançamento: ${games.releaseDate}',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 5.0),
                  AutoSizeText(
                    'Desenvolvedor: ${games.publisher.toString()}',
                    style: TextStyle(fontSize: 12),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
