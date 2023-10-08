import 'package:flutter/material.dart';
import 'package:gameroom/components/grid_game.dart';

class ViewAllPage extends StatefulWidget {
  final String title;
  const ViewAllPage({super.key, required this.title});

  @override
  State<ViewAllPage> createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
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
                              child: Column(
                                children: <Widget>[
                                  const Padding(
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
          // Expanded(
          //   child: Stack(
          //     children: [
          //       GridView.builder(
          //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 3,
          //           crossAxisSpacing: 8.0,
          //           mainAxisSpacing: 8.0,
          //         ),
          //         itemCount: loadedGames.length,
          //         itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          //           value: loadedGames[i],
          //           child: const GridGame(),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
