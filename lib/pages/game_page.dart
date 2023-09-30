import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gameroom/components/bagde.dart';
import 'package:gameroom/components/label_game.dart';
import 'package:gameroom/models/item.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GamePage extends StatefulWidget {
  final String cover;
  final String title;
  final String description;
  final String video;
  final List<String> genres;
  final List<String> platform;
  final List<String> publisher;
  final String releaseDate;

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
  final tabs = <Item>[
    Item(id: 0, name: 'DESCRIÇÃO'),
    Item(id: 1, name: 'IMAGENS'),
    Item(id: 2, name: 'JOGOS SEMELHANTES')
  ];

  @override
  void initState() {
    super.initState();
    String url = widget.video;
    String? id = YoutubePlayer.convertUrlToId(url);
    _tabController = TabController(length: 3, vsync: this);
    _controller = YoutubePlayerController(
      initialVideoId: id!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
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
            tabs: tabs.map((Item genre) {
              return Center(
                child: Container(
                    padding: EdgeInsets.only(bottom: 15.0, top: 15.0),
                    child: Text(genre.name,
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
              children: <Widget>[
                ListView(
                  children: [
                    LabelGame(
                        title: 'DATA DE LANÇAMENTO: ',
                        information: widget.releaseDate),
                    LabelGame(
                        title: 'DESENVOLVEDOR: ',
                        information: widget.publisher.toString()),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        'DESCRIÇÃO',
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
                      padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                      child: Text(
                        'GÊNERO',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    BadgeInformation(information: widget.genres),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, bottom: 10.0, top: 10.0),
                      child: Text(
                        'PLATAFORMAS',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    BadgeInformation(information: widget.platform),
                    SizedBox(
                      height: 30,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      IconButton(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        icon: Icon(Icons.favorite),
                        onPressed: () {
                          print('alo');
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          'Jogo marcado como favorito!',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ),
                    ]),
                  ],
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
