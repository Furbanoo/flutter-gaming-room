import 'package:flutter/material.dart';
import 'package:gameroom/pages/game_page.dart';
import 'package:provider/provider.dart';

class GridGame extends StatelessWidget {
  const GridGame({
    super.key,
  });

  void _selectedGame(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => GamePage(
    //       cover: games.cover,
    //       title: games.title,
    //       description: games.description,
    //       video: games.video,
    //       genres: games.genres,
    //       platform: games.platform,
    //       publisher: games.publisher,
    //       releaseDate: games.releaseDate,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectedGame(context),
      child: Stack(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(6),
          //   child: Image.network(
          //     games.cover,
          //     height: 400,
          //     width: 400,
          //     fit: BoxFit.cover,
          //   ),
          // ),
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
