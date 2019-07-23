import 'package:flutter/material.dart';
import 'package:pureride/ui/widgets/info_card.dart';

import '../../models/state.dart';
import '../../state_widget.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  StateModel appState;

  DefaultTabController _buildTabView({Widget body}) {
    const double _iconSize = 20.0;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            elevation: 2.0,
            title: Text("PureRide"),
            bottom: TabBar(
              labelColor: Theme.of(context).indicatorColor,
              tabs: [
                Text("Drivers"),
                Text("Requests"),
              ],
            )),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: Center(child: ListView(
            children: [
              InfoCard(id: 1, destinationName: 'Lazeez', departureTime: TimeOfDay.now(), address: '23 Lazeez Dr'),
              InfoCard(id: 2, destinationName: 'Lazeez', departureTime: TimeOfDay.now(), address: '23 Lazeez Dr'),
              InfoCard(id: 3, destinationName: 'Lazeez', departureTime: TimeOfDay.now(), address: '23 Lazeez Dr'),
            ]
          )),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (appState.isLoading)
      return _buildTabView(
        body: _buildLoadingIndicator(),
      );
    // TODO: wait till firebase auth works
    // else if (!appState.isLoading && appState.user == null)
    //   return LoginScreen();
    else if (!appState.isLoading && !appState.isLogin)
      return LoginScreen();
    else
      return _buildTabView(body: Text("hi"));
  }

  Center _buildLoadingIndicator() {
    return Center(
      child: new CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    return _buildContent();
  }
}
