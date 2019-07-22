import 'package:flutter/material.dart';
import 'package:pureride/ui/screens/home.dart';
import 'package:pureride/ui/screens/login.dart';
import 'package:pureride/ui/theme.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PureRide",
      theme: buildTheme(),
      initialRoute: '/login',
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      });
  }

}
