import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TimerItem extends StatefulWidget {
  final String title;
  int date;
  TimerItem({
    super.key,
    required this.title,
    required this.date,
  });

  @override
  State<TimerItem> createState() => _TimerItemState();
}

class _TimerItemState extends State<TimerItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(255, 255, 255, 0.5),
      width: 80,
      height: 80,
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              widget.date.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 46,
                fontWeight: FontWeight.bold,
              ),
            ),
            AutoSizeText(
              widget.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
