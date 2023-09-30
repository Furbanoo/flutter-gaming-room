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
                    "Novos Lançamentos".toUpperCase(),
                    style: TextStyle(
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
                          builder: (context) => ViewAllPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        "Ver Todos",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            HorizontalGrid(),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 10,
              ),
              child: Row(
                children: [
                  Text(
                    "Novos Jogos de Xbox One".toUpperCase(),
                    style: TextStyle(
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
                          builder: (context) => ViewAllPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        "Ver Todos",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            HorizontalGrid(),
          ],
        ),
      ),
    );
  }
}
