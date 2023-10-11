import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gameroom/components/divider_timer.dart';
import 'package:gameroom/components/timer_item.dart';
import 'package:gameroom/services/igdb_api.dart';
import 'package:intl/intl.dart';

import '../models/game.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<int> idGame = [];
  List<int> dateGame = [];
  List<Game> games = [];
  late List<Duration> timeDifference = [];
  late Timer timer;
  DateTime _currentGameDate = DateTime.now().toUtc();
  int _current = 0;
  final CarouselController _controller = CarouselController();

  _CarouselState() {
    timeDifference = List<Duration>.empty();
  }

  @override
  void initState() {
    fetchReleaseGames();
    startTimer();
    super.initState();
  }

  Future<void> fetchReleaseGames() async {
    try {
      final result = await gameReleaseCarousel();
      setState(() {
        dateGame = result.dateGame;
        idGame = result.idGame;
        timeDifference = List<Duration>.generate(
            dateGame.length, (index) => const Duration());
      });
      games = (await fetchGamesByIdsCarousel(idGame));
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao buscar os jogos: $e');
      }
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now().toUtc();

      if (dateGame.isNotEmpty) {
        for (int i = 0; i < dateGame.length; i++) {
          final timestampDateTime = DateTime.fromMillisecondsSinceEpoch(
            dateGame[i] * 1000,
            isUtc: true,
          );

          Duration difference = timestampDateTime.isAfter(now)
              ? timestampDateTime.difference(now)
              : const Duration();

          if (_current == i) {
            _currentGameDate = timestampDateTime;
          }
          timeDifference[i] = difference;
        }
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
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
      items: games
          .map((item) => SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: item.coverUrl!,
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
                        children: games.asMap().entries.map((entry) {
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
                          const Spacer(),
                          Text(
                            games[_current].name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat("d 'de' MMMM 'de' y", "pt_BR")
                                .format(_currentGameDate),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TimerItem(
                                title: 'DIAS',
                                date: timeDifference[_current].inDays,
                              ),
                              const DividerItem(),
                              TimerItem(
                                title: 'HORAS',
                                date: timeDifference[_current].inHours % 24,
                              ),
                              const DividerItem(),
                              TimerItem(
                                title: 'MINUTOS',
                                date: timeDifference[_current].inMinutes % 60,
                              ),
                            ],
                          ),
                          const Spacer(),
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
