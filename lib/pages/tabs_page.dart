import 'package:flutter/material.dart';
import 'package:gameroom/pages/favorite_page.dart';
import 'package:gameroom/pages/home_page.dart';
import 'package:gameroom/pages/console_page.dart';
import 'package:gameroom/pages/search_page.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedScreenIndex = 0;
  List<Map<String, Object>>? _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      {
        'screen': const HomePage(),
      },
      {
        'screen': const SearchPage(),
      },
      {
        'screen': const ConsolePage(),
      },
      {
        'screen': const FavoritePage(),
      },
    ];
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens![_selectedScreenIndex]['screen'] as Widget,
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        currentIndex: _selectedScreenIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.gamepad),
            label: 'Descubra',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.search),
            label: 'Pesquisar',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.sports_esports),
            label: 'Plataformas',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
