import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          // We set Size equal to passed height (50.0) and infinite width:
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 2.0,
            bottom: TabBar(
              tabs: [
                Text("Drivers"),
                Text("Requests")
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: Center(child: Text("hello"),),
        ),
      ),
    );
  }
}

