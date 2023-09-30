import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class LabelGame extends StatefulWidget {
  final String title;
  final dynamic information;

  const LabelGame({
    super.key,
    required this.title,
    required this.information,
  });

  @override
  State<LabelGame> createState() => _LabelGameState();
}

class _LabelGameState extends State<LabelGame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.only(left: 10.0, top: 5.0),
      child: Row(
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: AutoSizeText(
              widget.information,
              maxLines: 2,
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
