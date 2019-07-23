import 'package:flutter/material.dart';
import 'package:pureride/ui/widgets/AppBarTitle.dart';

class RequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppBarTitle(),),
      body: Center(child: Text("hello"),),
    );
  }
}