import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gameroom/components/search_game.dart';
import 'package:gameroom/models/game.dart';
import 'package:gameroom/services/igdb_api.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchQuery = TextEditingController();
  late Widget _searchBar = const Text(
    "Pesquisar",
    style: TextStyle(fontSize: 16),
  );
  bool _isLoaded = true;
  late Widget _search;
  List<Game> games = [];

  @override
  void initState() {
    super.initState();
    FocusNode searchFocusNode = FocusNode();
    _search = IconButton(
      onPressed: () {
        setState(() {
          _searchBar = Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: Color(0XFF9f5afd),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    focusNode: searchFocusNode,
                    textInputAction: TextInputAction.search,
                    style:
                        const TextStyle(fontSize: 16, color: Color(0XFF9f5afd)),
                    controller: _searchQuery,
                    onSubmitted: (_) async {
                      setState(() {
                        _isLoaded = false;
                      });
                      games = (await search(_searchQuery.text));
                      setState(() {
                        _isLoaded = true;
                      });
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _searchQuery.clear();
                  },
                  icon: const Icon(Icons.close),
                )
              ],
            ),
          );
          _search = IconButton(
              onPressed: () async {
                searchFocusNode.unfocus();
                setState(() {
                  _isLoaded = false;
                });
                games = (await search(_searchQuery.text));
                setState(() {
                  _isLoaded = true;
                });
              },
              icon: const Icon(Icons.check));
        });
      },
      icon: const Icon(Icons.search),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: _searchBar,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: _search,
          )
        ],
      ),
      body: _isLoaded
          ? games.isEmpty
              ? const Center(
                  child: AutoSizeText(
                    "",
                    maxLines: 1,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: games.length,
                  itemBuilder: (ctx, i) {
                    return SearchGame(games: games[i]);
                  })
          : const CircularProgressIndicator(),
    );
  }
}
