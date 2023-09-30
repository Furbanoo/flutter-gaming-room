import 'package:flutter/material.dart';
import 'package:gameroom/components/grid_game.dart';
import 'package:gameroom/components/list_game.dart';
import 'package:gameroom/models/games.dart';
import 'package:gameroom/models/games_list.dart';
import 'package:provider/provider.dart';

class ViewAllPage extends StatefulWidget {
  const ViewAllPage({super.key});

  @override
  State<ViewAllPage> createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  bool _isGrid = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GamesList>(context);
    final List<Games> loadedGames = provider.games;
    IconData _currentIcon = _isGrid ? Icons.list : Icons.grid_view;
    Widget _currentGrid = _isGrid
        ? Expanded(
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
          )
        : Expanded(
            child: ListView.builder(
              itemCount: loadedGames.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: loadedGames[i],
                child: const ListGame(),
              ),
            ),
          );

    void _toggleGrid() {
      setState(() {
        _isGrid = !_isGrid;
      });
    }

    return Scaffold(
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
                  'Novos Lançamentos'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Icon(_currentIcon),
                    onPressed: _toggleGrid,
                  ),
                ),
              ],
            ),
          ),
          _currentGrid,
        ],
      ),
    );
  }
}
