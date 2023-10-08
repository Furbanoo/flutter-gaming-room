import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gameroom/components/divider_timer.dart';
import 'package:gameroom/components/timer_item.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

final List<String> gameBackground = [
  'https://upload.wikimedia.org/wikipedia/pt/0/09/Final_Fantasy_VII_Remake_capa.png',
  'https://image.api.playstation.com/vulcan/img/rnd/202010/2217/LsaRVLF2IU2L1FNtu9d3MKLq.jpg',
  'https://cdn1.epicgames.com/offer/4bc43145bb8245a5b5cc9ea262ffbe0e/EGS_MarvelsSpiderManRemastered_InsomniacGamesNixxesSoftware_S2_1200x1600-76424286902489f4d9639ac9b735c2b2',
  'https://image.api.playstation.com/vulcan/img/rnd/202010/2618/itbSm3suGHSSHIpmu9CCPBRy.jpg',
];

final List<String> gameTitle = [
  'Final Fantasy VII Remake',
  'God of War',
  'Marvel Spider-Man',
  'The Last of Us 2',
];

class _CarouselState extends State<Carousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        autoPlayInterval: const Duration(seconds: 8),
        autoPlayAnimationDuration: const Duration(milliseconds: 2500),
        height: MediaQuery.of(context).size.height / 3,
        enlargeCenterPage: true,
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
      items: gameBackground
          .map((item) => SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: item,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: gameBackground.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Spacer(),
                          Text(
                            gameTitle[_current],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '02 de novembro de 2023',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TimerItem(title: 'DIAS'),
                              DividerItem(),
                              TimerItem(title: 'HORAS'),
                              DividerItem(),
                              TimerItem(
                                title: 'MINUTOS',
                              ),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
      carouselController: _controller,
    );
  }
}
