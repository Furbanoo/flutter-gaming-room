import 'package:flutter/material.dart';
import 'package:gameroom/models/games.dart';
import 'package:gameroom/pages/game_page.dart';
import 'package:provider/provider.dart';

class GameContainerItem extends StatelessWidget {
  const GameContainerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final games = Provider.of<Games>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GamePage(
                cover: games.cover,
                description: games.description,
                genres: games.genres,
                platform: games.platform,
                publisher: games.publisher,
                releaseDate: games.releaseDate,
                title: games.title,
                video: games.video,
              ),
            ),
          );
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
                games.cover,
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
