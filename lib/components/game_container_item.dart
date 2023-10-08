import 'package:flutter/material.dart';
import 'package:gameroom/pages/game_page.dart';
import 'package:gameroom/services/igdb_api.dart';

import '../models/game.dart';

class GameContainerItem extends StatefulWidget {
  final Game game;
  const GameContainerItem({
    required this.game,
    super.key,
  });

  @override
  State<GameContainerItem> createState() => _GameContainerItemState();
}

class _GameContainerItemState extends State<GameContainerItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => GamePage(
          //       cover: games.cover,
          //       description: games.description,
          //       genres: games.genres,
          //       platform: games.platform,
          //       publisher: games.publisher,
          //       releaseDate: games.releaseDate,
          //       title: games.title,
          //       video: games.video,
          //     ),
          //   ),
          // );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              elevation: 5,
              shadowColor: const Color(0xCC000000),
              child: Image.network(
                widget.game.coverUrl!,
                //placeholder: "assets/placeholder_box.png",
                width: 120,
                height: 120 * 1.50,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
