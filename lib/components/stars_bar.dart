import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gameroom/models/rate_formatter.dart';

class StarsBar extends StatefulWidget {
  final double stars;
  const StarsBar({
    super.key,
    required this.stars,
  });

  @override
  State<StarsBar> createState() => _StarsBarState();
}

class _StarsBarState extends State<StarsBar> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: RatingFormmater.formattedRating(widget.stars),
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemSize: 22,
      ignoreGestures: true,
      itemCount: 5,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
