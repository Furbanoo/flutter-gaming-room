import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gameroom/components/stars_bar.dart';
import 'package:gameroom/models/date_formatter.dart';
import 'package:gameroom/models/game.dart';
import 'package:gameroom/models/rate_formatter.dart';
import 'package:gameroom/pages/game_page.dart';

class SearchGame extends StatefulWidget {
  final Game games;
  SearchGame({
    super.key,
    required this.games,
  });

  @override
  State<SearchGame> createState() => _SearchGameState();
}

class _SearchGameState extends State<SearchGame> {
  void _selectedGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GamePage(
          id: widget.games.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectedGame(context),
      child: Container(
        margin: const EdgeInsets.only(left: 10.0, bottom: 20.0, top: 12.0),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: Image.network(
                widget.games.coverUrl!,
                width: 120,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              width: 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    widget.games.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      StarsBar(stars: widget.games.totalRating!),
                      widget.games.totalRating! > 1
                          ? Container(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Text(
                                RatingFormmater.formattedRating(
                                        widget.games.totalRating!)
                                    .toStringAsFixed(2)
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.yellow.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Text('Sem classificação',
                              style: TextStyle(color: Colors.grey.shade500)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      'Data de Lançamento: ${DateFormatter.formatUnixDate(widget.games.firstReleaseDate!)}',
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  AutoSizeText(
                    'Resumo: ${widget.games.summary}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    maxLines: 5,
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
