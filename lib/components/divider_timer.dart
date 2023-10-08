import 'package:flutter/material.dart';

class DividerItem extends StatefulWidget {
  const DividerItem({super.key});

  @override
  State<DividerItem> createState() => _DividerItemState();
}

class _DividerItemState extends State<DividerItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '|',
        style: TextStyle(
          color: Colors.white,
          fontSize: 68,
        ),
      ),
    );
  }
}
