import 'package:flutter/material.dart';
import 'package:gameroom/components/carousel.dart';
import 'package:gameroom/components/horizontal_grid.dart';
import 'package:gameroom/pages/view_all_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> titles = [
    'Últimos Lançamentos',
    'Lançamentos Futuros',
    'Os mais bem avaliados',
    'Mais esperados',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Carousel(),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 10,
              ),
              child: Row(
                children: [
                  Text(
                    titles[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewAllPage(title: titles[0]),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        "Ver Todos",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const HorizontalGrid(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: Row(
                children: [
                  Text(
                    titles[1].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewAllPage(
                            title: titles[1],
                          ),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        "Ver Todos",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const HorizontalGrid(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(16.0),
                splashColor: Theme.of(context).colorScheme.primary,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(1.0),
                        Theme.of(context).colorScheme.onPrimary,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'lib/assets/images/trophy.png',
                        fit: BoxFit.contain,
                        width: 140,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            titles[2],
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Ver todos',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(16.0),
                splashColor: Theme.of(context).colorScheme.onSecondary,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context)
                            .colorScheme
                            .onSecondary
                            .withOpacity(1.0),
                        Theme.of(context).colorScheme.onSecondary,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'lib/assets/images/fire.png',
                        fit: BoxFit.contain,
                        width: 140,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            titles[3],
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Ver todos',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
