import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PureRide")
      ),
      body: Center(
        child: MaterialButton(
          child: Text("a"),
          onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
        ),),
    );
  }
}

