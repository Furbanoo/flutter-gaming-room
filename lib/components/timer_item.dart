import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TimerItem extends StatefulWidget {
  final String title;
  const TimerItem({
    super.key,
    required this.title,
  });

  @override
  State<TimerItem> createState() => _TimerItemState();
}

class _TimerItemState extends State<TimerItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      width: 85,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              '00',
              style: TextStyle(
                color: Colors.black,
                fontSize: 56,
                fontWeight: FontWeight.bold,
              ),
            ),
            AutoSizeText(
              widget.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
