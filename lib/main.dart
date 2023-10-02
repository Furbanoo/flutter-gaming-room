import 'package:flutter/material.dart';
import 'package:gameroom/models/consoles.dart';
import 'package:gameroom/models/consoles_list.dart';
import 'package:gameroom/models/games.dart';
import 'package:gameroom/models/games_list.dart';
import 'package:gameroom/pages/tabs_page.dart';
import 'package:gameroom/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Games(
            cover: '',
            title: '',
            description: '',
            video: '',
            genres: [''],
            platform: [''],
            publisher: '',
            releaseDate: [''],
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => GamesList(),
        ),
        ChangeNotifierProvider(
          create: (_) => ConsolesList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Consoles(background: '', title: ''),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const TabsPage(),
        theme: Provider.of<ThemeProvider>(context).themeData,
      ),
    );
  }
}
