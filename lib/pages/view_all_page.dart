import 'package:flutter/material.dart';
import 'package:gameroom/components/grid_game.dart';
import 'package:gameroom/models/game.dart';
import 'package:gameroom/services/igdb_api.dart';

class ViewAllPage extends StatefulWidget {
  final String title;
  final int page;
  const ViewAllPage({
    super.key,
    required this.title,
    required this.page,
  });

  @override
  State<ViewAllPage> createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  List<Game> games = [];
  bool _isLoading = true;
  ScrollController _scrollController = ScrollController();
  int currentPage = 1;

  @override
  initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreGames();
      }
    });
    getData();
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });
    List<int> id = (await getIdsGames(widget.page));
    games = (await fetchGamesByIds(id));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _loadMoreGames() async {
    List<int> nextPageIds = await getIdsGames(widget.page);
    List<Game> nextPageGames = await fetchGamesByIds(nextPageIds);

    setState(() {
      games.addAll(nextPageGames);
      currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    icon: Icon(Icons.filter_alt,
                        color: Theme.of(context).colorScheme.inversePrimary),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.8,
                              ),
                              child: const Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.0, bottom: 10.0),
                                    child: Text(
                                      'Filtros',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                if (!_isLoading)
                  GridView.builder(
                      controller: _scrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: games.length + 1,
                      itemBuilder: (ctx, i) {
                        if (i < games.length) {
                          return GridGame(game: games[i]);
                        } else {
                          // Exibir o indicador de carregamento enquanto carrega mais jogos
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      }),
                if (_isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.inversePrimary,
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
