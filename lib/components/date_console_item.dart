import 'package:flutter/material.dart';

class DateConsoleItem extends StatefulWidget {
  final String console;
  final String date;
  const DateConsoleItem({
    super.key,
    required this.console,
    required this.date,
  });

  @override
  State<DateConsoleItem> createState() => _DateConsoleItemState();
}

class _DateConsoleItemState extends State<DateConsoleItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 10.0),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(
                    width: 1.0,
                    color: Theme.of(context).colorScheme.inversePrimary)),
            child: Text(
              widget.console,
              maxLines: 2,
              style: TextStyle(
                height: 1.4,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
        Text(
          widget.date,
          style:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
