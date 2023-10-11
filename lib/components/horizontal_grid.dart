import 'package:flutter/material.dart';
import 'package:gameroom/components/game_container_item.dart';
import 'package:gameroom/services/igdb_api.dart';

import '../models/game.dart';

class HorizontalGrid extends StatefulWidget {
  final int page;
  const HorizontalGrid({
    super.key,
    required this.page,
  });

  @override
  State<HorizontalGrid> createState() => _HorizontalGridState();
}

class _HorizontalGridState extends State<HorizontalGrid> {
  List<Game> games = [];

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() async {
    List<int> id = (await getIdsGames(widget.page));
    games = (await fetchGamesByIds(id));
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size.fromHeight(200),
      child: ListView.builder(
        itemCount: games.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 10, top: 5),
        itemBuilder: (BuildContext ctx, int i) {
          return GameContainerItem(game: games[i]);
        },
      ),
    );
  }
}
