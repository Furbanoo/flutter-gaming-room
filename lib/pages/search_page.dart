import 'package:flutter/material.dart';
import 'package:gameroom/components/search_game.dart';
import 'package:gameroom/models/games.dart';
import 'package:gameroom/models/games_list.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GamesList>(context);
    final List<Games> loadedGames = provider.games;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 40.0, right: 10.0),
            child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () {},
                onChanged: (_) {},
                leading: const Icon(Icons.search),
              );
            }, suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              });
            }),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: loadedGames.length,
                itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                      value: loadedGames[index],
                      child: SearchGame(),
                    )),
          ),
        ],
      ),
    );
  }
}
