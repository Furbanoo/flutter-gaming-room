import 'package:flutter/material.dart';
import 'package:gameroom/components/game_container_item.dart';
import 'package:gameroom/models/games.dart';
import 'package:gameroom/models/games_list.dart';
import 'package:provider/provider.dart';

class HorizontalGrid extends StatelessWidget {
  const HorizontalGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GamesList>(context);
    final List<Games> loadedGames = provider.games;
    return SizedBox.fromSize(
      size: const Size.fromHeight(200),
      child: ListView.builder(
        itemCount: loadedGames.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 10, top: 5),
        itemBuilder: (BuildContext ctx, int i) => ChangeNotifierProvider.value(
          value: loadedGames[i],
          child: GameContainerItem(),
        ),
      ),
    );
  }
}
