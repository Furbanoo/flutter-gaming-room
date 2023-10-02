import 'package:flutter/material.dart';
import 'package:gameroom/components/console_item.dart';
import 'package:gameroom/models/consoles.dart';
import 'package:gameroom/models/consoles_list.dart';
import 'package:provider/provider.dart';

class ConsolePage extends StatefulWidget {
  const ConsolePage({super.key});

  @override
  State<ConsolePage> createState() => _ConsolePageState();
}

class _ConsolePageState extends State<ConsolePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConsolesList>(context);
    final List<Consoles> loadedConsoles = provider.consoles;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 10,
              ),
              child: Row(
                children: [
                  const Spacer(),
                  const Spacer(),
                  Text(
                    'Jogos por plataforma'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ChangeNotifierProvider.value(
                    value: loadedConsoles[index],
                    child: const ConsoleItem(),
                  );
                },
                childCount: loadedConsoles.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
