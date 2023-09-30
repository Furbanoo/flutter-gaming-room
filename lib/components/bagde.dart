import 'package:flutter/material.dart';

class BadgeInformation extends StatefulWidget {
  final List<String> information;

  const BadgeInformation({
    super.key,
    required this.information,
  });

  @override
  State<BadgeInformation> createState() => _BadgeInformationState();
}

class _BadgeInformationState extends State<BadgeInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      padding: EdgeInsets.only(
        left: 10.0,
        top: 5.0,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.information.length,
        itemBuilder: (ctx, i) {
          return Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(
                      width: 1.0,
                      color: Theme.of(context).colorScheme.inversePrimary)),
              child: Text(
                widget.information[i],
                maxLines: widget.information.length,
                style: TextStyle(
                  height: 1.4,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 9.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
