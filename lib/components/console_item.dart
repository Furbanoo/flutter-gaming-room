import 'package:flutter/material.dart';
import 'package:gameroom/models/consoles.dart';
import 'package:gameroom/pages/view_all_page.dart';
import 'package:provider/provider.dart';

class ConsoleItem extends StatefulWidget {
  const ConsoleItem({super.key});

  @override
  State<ConsoleItem> createState() => _ConsoleItemState();
}

class _ConsoleItemState extends State<ConsoleItem> {
  @override
  Widget build(BuildContext context) {
    final consoles = Provider.of<Consoles>(context);
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ViewAllPage(title: consoles.title),
        //   ),
        // );
      },
      borderRadius: BorderRadius.circular(16.0),
      splashColor: Theme.of(context).colorScheme.primary,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.secondary.withOpacity(1.0),
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: Image.network(
          consoles.background,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
