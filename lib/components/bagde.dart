import 'package:flutter/material.dart';

class BadgeInformation extends StatefulWidget {
  final String information;
  final VoidCallback? onPressed;

  const BadgeInformation({
    super.key,
    required this.information,
    this.onPressed,
  });

  @override
  State<BadgeInformation> createState() => _BadgeInformationState();
}

class _BadgeInformationState extends State<BadgeInformation> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        height: 30.0,
        padding: const EdgeInsets.only(
          left: 10.0,
          top: 5.0,
        ),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(
                  width: 1.0,
                  color: Theme.of(context).colorScheme.inversePrimary)),
          child: Text(
            widget.information,
            maxLines: widget.information.length,
            style: TextStyle(
              height: 1.4,
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.bold,
              fontSize: 10.0,
            ),
          ),
        ),
      ),
    );
  }
}
