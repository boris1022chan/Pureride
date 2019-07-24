import 'package:flutter/material.dart';

BoxDecoration buildBackground() {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/intersection.jpeg"),
      fit: BoxFit.cover,
      colorFilter: new ColorFilter.mode(
          Colors.black.withOpacity(0.6), BlendMode.darken),
    ),
  );
}

Text buildText(context) {
  return Text(
    'PureRide',
    style: Theme.of(context).textTheme.headline,
    textAlign: TextAlign.center,
  );
}
