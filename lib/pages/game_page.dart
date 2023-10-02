import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gameroom/components/bagde.dart';
import 'package:gameroom/components/date_console_item.dart';
import 'package:gameroom/components/detail_item.dart';
import 'package:gameroom/models/item.dart';
import 'package:gameroom/pages/view_all_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GamePage extends StatefulWidget {
  final String cover;
  final String title;
  final String description;
  final String video;
  final List<String> genres;
  final List<String> platform;
  final String publisher;
  final List<String> releaseDate;

  const GamePage({
    super.key,
    required this.cover,
    required this.title,
    required this.description,
    required this.video,
    required this.genres,
    required this.platform,
    required this.publisher,
    required this.releaseDate,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  YoutubePlayerController? _controller;
  late TabController _tabController;
  bool _isFavorite = false;
  final tabs = <Item>[
    Item(id: 0, name: 'DESCRIÇÃO'),
    Item(id: 1, name: 'IMAGENS'),
    Item(id: 2, name: 'JOGOS SEMELHANTES')
  ];

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

  void _showModal(String title) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        if (title == "date") {
          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: const Text(
                    'Datas de Lançamento',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.platform.length,
                      itemBuilder: (ctx, i) {
                        return DateConsoleItem(
                            console: widget.platform[i],
                            date: widget.releaseDate[i]);
                      }),
                ),
              ],
            ),
          );
        }
        if (title == "language") {
          return Center();
        }
        if (title == "storyline") {
          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: const Text(
                    'Enredo do Jogo',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, bottom: 10.0, right: 10.0),
                  child: Text(
                    widget.description,
                    maxLines: 30,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 11.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Center();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    String url = widget.video;
    String? id = YoutubePlayer.convertUrlToId(url);
    _tabController = TabController(length: 3, vsync: this);
    _controller = YoutubePlayerController(
      initialVideoId: id!,
      flags: const YoutubePlayerFlags(
        autoPlay: true, ////RETIRAR QUANDO ACABAR
        mute: false,
        loop: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Stack(
            children: [
              YoutubePlayer(
                controller: _controller!,
                showVideoProgressIndicator: true,
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
              Positioned(
                bottom: 10.0,
                left: 0.0,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: ClipOval(
                        child: Image.network(
                          widget.cover,
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                    padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                    child: Text(tab.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                        ))),
              );
            }).toList(),
          ),
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
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              widget.title.toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade700,
                          ),
                          Text(
                            '5.0',
                            style: TextStyle(
                                color: Colors.yellow.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: InkWell(
                          onTap: () {
                            _showModal('date');
                          },
                          child: Text(
                            widget.releaseDate[0],
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: BadgeInformation(information: widget.platform),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DetailItem(
                            icon: Icons.list,
                            title: 'Franquia'.toUpperCase(),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewAllPage(
                                    title: 'TESTEEE',
                                  ),
                                ),
                              );
                            },
                          ),
                          DetailItem(
                            icon: Icons.extension,
                            title: 'DLCs'.toUpperCase(),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewAllPage(
                                    title: 'TESTEEE',
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DetailItem(
                            icon: Icons.category,
                            title: 'Versões'.toUpperCase(),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewAllPage(
                                    title: 'TESTEEE',
                                  ),
                                ),
                              );
                            },
                          ),
                          DetailItem(
                            icon: Icons.code,
                            title: 'Produtora'.toUpperCase(),
                            name: widget.publisher,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewAllPage(
                                    title: 'TESTEEE',
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DetailItem(
                            icon: Icons.publish,
                            title: 'Distribuidora',
                            name: widget.publisher,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewAllPage(
                                    title: 'TESTEEE',
                                  ),
                                ),
                              );
                            },
                          ),
                          DetailItem(
                            icon: Icons.language,
                            title: 'Idiomas'.toUpperCase(),
                            onPressed: () {
                              _showModal('language');
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'GÊNERO',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      BadgeInformation(
                          information: widget.genres,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewAllPage(
                                  title: 'aaaaa',
                                ),
                              ),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'TAGs',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      BadgeInformation(
                        information: widget.genres,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewAllPage(
                                title: 'BBBBB',
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0),
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
                          widget.description,
                          maxLines: 30,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                      Padding(
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
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0),
                          child: GridView.count(
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 1.33,
                            crossAxisCount: 3,
                            children: List.generate(10, (index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                columnCount: 3,
                                duration: const Duration(milliseconds: 375),
                                child: ScaleAnimation(
                                    child: FadeInAnimation(
                                  child: AspectRatio(
                                    aspectRatio: 4 / 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        image: DecorationImage(
                                            image: NetworkImage(''),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                )),
                              );
                            }),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  child: Text('Testeeee 3'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
