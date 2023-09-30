import 'package:flutter/material.dart';
import 'package:gameroom/data/dummy_consoles.dart';
import 'package:gameroom/models/consoles.dart';

class ConsolesList with ChangeNotifier {
  final List<Consoles> _consoles = dummyConsoles;

  List<Consoles> get consoles => [..._consoles];
}
