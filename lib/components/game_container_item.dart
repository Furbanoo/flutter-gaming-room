import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gameroom/pages/game_page.dart';

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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GamePage(
                id: widget.game.id,
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
              child: CachedNetworkImage(
                imageUrl: widget.game.coverUrl!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
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
