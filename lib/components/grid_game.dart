import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gameroom/models/game.dart';
import 'package:gameroom/pages/game_page.dart';

class GridGame extends StatefulWidget {
  final Game game;
  const GridGame({
    super.key,
    required this.game,
  });

  @override
  State<GridGame> createState() => _GridGameState();
}

class _GridGameState extends State<GridGame> {
  void _selectedGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GamePage(
          id: widget.game.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectedGame(context),
      child: Stack(
        children: [
          Text(widget.game.name),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: widget.game.coverUrl!,
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
        ],
      ),
    );
  }
}
