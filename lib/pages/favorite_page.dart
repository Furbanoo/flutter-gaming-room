import 'package:flutter/material.dart';
import 'package:gameroom/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: (Theme.of(context).brightness == Brightness.light
            ? Text(
                'Modo Diurno',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : Text(
                'Modo Noturno',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )),
        onPressed: () {
          Provider.of<ThemeProvider>(
            context,
            listen: false,
          ).toggleTheme();
        },
      ),
    );
  }
}
