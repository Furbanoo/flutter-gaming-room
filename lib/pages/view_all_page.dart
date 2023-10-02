import 'package:flutter/material.dart';
import 'package:gameroom/components/grid_game.dart';
import 'package:gameroom/models/games.dart';
import 'package:gameroom/models/games_list.dart';
import 'package:provider/provider.dart';

class ViewAllPage extends StatefulWidget {
  final String title;
  const ViewAllPage({super.key, required this.title});

  @override
  State<ViewAllPage> createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GamesList>(context);
    final List<Games> loadedGames = provider.games;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 10,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                Text(
                  widget.title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: const Icon(Icons.filter_alt),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: loadedGames.length,
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                    value: loadedGames[i],
                    child: const GridGame(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
