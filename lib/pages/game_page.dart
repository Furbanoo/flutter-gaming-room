import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gameroom/components/bagde.dart';
import 'package:gameroom/components/date_console_item.dart';
import 'package:gameroom/components/detail_item.dart';
import 'package:gameroom/components/grid_game.dart';
import 'package:gameroom/components/stars_bar.dart';
import 'package:gameroom/components/video_player.dart';
import 'package:gameroom/models/date_formatter.dart';
import 'package:gameroom/models/game_details.dart';
import 'package:gameroom/models/item.dart';
import 'package:gameroom/models/rate_formatter.dart';
import 'package:gameroom/pages/view_all_page.dart';
import 'package:gameroom/services/igdb_api.dart';
import 'package:photo_view/photo_view.dart';

class GamePage extends StatefulWidget {
  final int id;

  const GamePage({
    super.key,
    required this.id,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isFavorite = false;
  bool _isLoading = true;
  late GameDetails game;
  String publisher = '';
  List<int> dlcs = [];
  List<int> franchise = [];

  final tabs = <Item>[
    Item(id: 0, name: 'DESCRIÇÃO'),
    Item(id: 1, name: 'IMAGENS'),
    Item(id: 2, name: 'JOGOS SEMELHANTES')
  ];

  final List<String> title = [
    'Franquia',
    'DLCs',
    'Versões',
    'Produtora',
    'Distribuidora',
    'Idiomas',
  ];

  @override
  void initState() {
    super.initState();
    getData(widget.id);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  getData(gameId) async {
    setState(() {
      _isLoading = true;
    });
    game = (await gameDetails(gameId));
    setState(() {
      _isLoading = false;
    });
    if (mounted) {
      setState(() {
        if (game.companies!.isNotEmpty) {
          if (game.companies!.length > 1) {
            publisher = game.companies![1].name;
          } else {
            publisher = game.companies![0].name;
          }
        }

        if (game.dlcs!.isNotEmpty) {
          for (int i = 0; i < game.dlcs!.length; i++) {
            dlcs.add(game.dlcs![i].id);
          }
        }

        if (game.franchises!.isNotEmpty) {
          for (int i = 0; i < game.franchises!.length; i++) {
            franchise.add(game.franchises![i]);
          }
        }
        print(franchise);
        print('ID: ${game.id}');
      });
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    final snackBar = SnackBar(
        content: Text(_isFavorite
            ? 'Adicionado aos favoritos!'
            : 'Removido dos favoritos!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void notAvailable(String info) {
    String message = '';
    if (info == title[0].toString()) {
      message = '${game.name} não possui Franquia!';
    } else if (info == title[1].toString()) {
      message = '${game.name} não possui DLC!';
    } else if (info == title[2]) {
      message = '${game.name} não possui versões';
    } else if (info == title[3]) {
      message = 'A Produtora de ${game.name} não possui demais jogos';
    } else if (info == title[4]) {
      message = 'A Distribuidora de ${game.name} não possui demais jogos';
    }
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showModal(String title) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        if (title == "date") {
          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height *
                  (0.1 * game.platforms!.length),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Text(
                    'Datas de Lançamento',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: game.platforms!.length,
                      itemBuilder: (ctx, i) {
                        return DateConsoleItem(
                          console: game.platforms![i].name,
                          date: DateFormatter.formatUnixDate(
                              game.releaseDate![i]),
                        );
                      }),
                ),
              ],
            ),
          );
        }
        if (title == "language") {
          return const Center();
        }
        if (title == "storyline") {
          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Text(
                    'Enredo do Jogo',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, bottom: 10.0, right: 10.0),
                  child: Text(
                    game.storyline!,
                    maxLines: 30,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 11.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Center();
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          if (!_isLoading)
            Stack(
              children: [
                game.videos != null && game.videos!.isNotEmpty
                    ? VideoPlayer(game.videos?[0].videoId)
                    : Container(
                        height: 240,
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://images.igdb.com/igdb/image/upload/t_original/${game.screenshots![0]}.png",
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          fit: BoxFit.contain,
                        ),
                      ),
                Positioned(
                  top: 20.0,
                  left: 0.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          if (!_isLoading)
            TabBar(
              controller: _tabController,
              indicatorColor: Theme.of(context).colorScheme.onPrimary,
              unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
              indicatorWeight: 2.0,
              labelColor: Theme.of(context).colorScheme.secondary,
              isScrollable: false,
              tabs: tabs.map((Item tab) {
                return Center(
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                      child: Text(tab.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13.0,
                          ))),
                );
              }).toList(),
            ),
          if (!_isLoading)
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 300,
                              margin: const EdgeInsets.only(left: 10),
                              child: AutoSizeText(
                                game.name.toUpperCase(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            IconButton(
                              onPressed: _toggleFavorite,
                              icon: Icon(
                                _isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child:
                                  StarsBar(stars: game.totalRating!.toDouble()),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            game.totalRating! > 1
                                ? Text(
                                    RatingFormmater.formattedRating(
                                            game.totalRating!)
                                        .toStringAsFixed(2)
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.yellow.shade700,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text('Sem classificação',
                                    style:
                                        TextStyle(color: Colors.grey.shade500)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 6.0),
                          child: InkWell(
                              onTap: () {
                                game.releaseDate != null &&
                                        game.videos!.isNotEmpty
                                    ? _showModal('date')
                                    : null;
                              },
                              child: game.firstReleaseDate! != -1
                                  ? Text(
                                      DateFormatter.formatUnixDate(
                                          game.firstReleaseDate!),
                                      style: TextStyle(
                                          color: Colors.grey.shade500),
                                    )
                                  : Text(
                                      'Jogo sem previsão de lançamento',
                                      style: TextStyle(
                                          color: Colors.grey.shade500),
                                    )),
                        ),
                        SizedBox(
                          height: 30,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: game.platforms!.length,
                              itemBuilder: (ctx, i) {
                                return BadgeInformation(
                                    information: game.platforms![i].name);
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DetailItem(
                              icon: Icons.list,
                              title: title[0].toUpperCase(),
                              onPressed: () {
                                if (game.franchises!.isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewAllPage(
                                        title: title[0],
                                        id: franchise,
                                        type: 0,
                                      ),
                                    ),
                                  );
                                } else {
                                  notAvailable(title[0].toString());
                                }
                              },
                            ),
                            DetailItem(
                              icon: Icons.extension,
                              title: title[1].toUpperCase(),
                              onPressed: () {
                                if (game.dlcs!.isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewAllPage(
                                        title: title[1],
                                        id: dlcs,
                                        type: 1,
                                      ),
                                    ),
                                  );
                                } else {
                                  notAvailable(title[1].toString());
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DetailItem(
                              icon: Icons.category,
                              title: title[2].toUpperCase(),
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const ViewAllPage(
                                //       title: 'TESTEEE',
                                //     ),
                                //   ),
                                // );
                              },
                            ),
                            DetailItem(
                              icon: Icons.code,
                              title: title[3].toUpperCase(),
                              name: game.companies!.isNotEmpty
                                  ? game.companies![0].name
                                  : 'Desconhecida',
                              onPressed: () {
                                game.companies!.isNotEmpty
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ViewAllPage(
                                            title: 'TESTEEE',
                                            page: 4,
                                          ),
                                        ),
                                      )
                                    : print('');
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DetailItem(
                              icon: Icons.publish,
                              title: title[4],
                              name: game.companies!.isNotEmpty
                                  ? publisher
                                  : 'Desconhecida',
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const ViewAllPage(
                                //       title: 'TESTEEE',
                                //     ),
                                //   ),
                                // );
                              },
                            ),
                            DetailItem(
                              icon: Icons.language,
                              title: title[5].toUpperCase(),
                              onPressed: () {
                                _showModal('language');
                              },
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'GÊNERO',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: game.genres!.length,
                              itemBuilder: (ctx, i) {
                                return BadgeInformation(
                                    information: game.genres![i].toString(),
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => const ViewAllPage(
                                      //       title: 'aaaaa',
                                      //     ),
                                      //   ),
                                      // );
                                    });
                              }),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'TAGs',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        game.themes!.isNotEmpty
                            ? SizedBox(
                                height: 30,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: game.themes!.length,
                                    itemBuilder: (ctx, i) {
                                      return BadgeInformation(
                                          information:
                                              game.themes![i].toString(),
                                          onPressed: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => const ViewAllPage(
                                            //       title: 'aaaaa',
                                            //     ),
                                            //   ),
                                            // );
                                          });
                                    }),
                              )
                            : Container(),
                        game.gameModes!.isNotEmpty
                            ? SizedBox(
                                height: 30,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: game.gameModes!.length,
                                    itemBuilder: (ctx, i) {
                                      return BadgeInformation(
                                          information:
                                              game.gameModes![i].toString(),
                                          onPressed: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => const ViewAllPage(
                                            //       title: 'aaaaa',
                                            //     ),
                                            //   ),
                                            // );
                                          });
                                    }),
                              )
                            : Container(),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 10.0),
                          child: Text(
                            'RESUMO',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            game.summary!,
                            maxLines: 30,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 11.0,
                            ),
                          ),
                        ),
                        game.storyline == null
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: DetailItem(
                                  icon: Icons.book,
                                  title: 'Enredo',
                                  onPressed: () {
                                    _showModal('storyline');
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: AnimationLimiter(
                          child: AnimationLimiter(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 10.0, right: 10.0),
                              child: GridView.count(
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 1.33,
                                crossAxisCount: 3,
                                children: List.generate(
                                  game.screenshots!.length,
                                  (int index) {
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      columnCount: 3,
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return PhotoView(
                                                      imageProvider: NetworkImage(
                                                          'https://images.igdb.com/igdb/image/upload/t_screenshot_big/${game.screenshots![index]}.jpg'),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: AspectRatio(
                                              aspectRatio: 4 / 3,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          "https://images.igdb.com/igdb/image/upload/t_screenshot_big/${game.screenshots![index]}.jpg",
                                                        ),
                                                        fit: BoxFit.cover)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: game.similarGames!.length,
                      itemBuilder: (ctx, i) {
                        return GridGame(game: game.similarGames![i]);
                      }),
                ],
              ),
            ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
        ],
      ),
    );
  }
}
