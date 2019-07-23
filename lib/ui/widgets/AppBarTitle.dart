import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset('assets/logo.png', fit: BoxFit.contain, height: 32),
        SizedBox(width: 5.0),
        Text(
          "PureRide",
          style: Theme.of(context).textTheme.title,
        ),
      ],
    );
  }
}
