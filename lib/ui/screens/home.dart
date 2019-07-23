import 'package:flutter/material.dart';
import 'package:pureride/ui/theme.dart';
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

  Widget buildAppBarTab(String str) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        str,
        style: buildAppBarStyle(),
      ),
    );
  }

  DefaultTabController _buildTabView({Widget body}) {
    const double _iconSize = 20.0;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            elevation: 2.0,
            title: Row(
              children: <Widget>[
                Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                  height: 32
                ),
                SizedBox(width: 5.0),
                Text(
                  "PureRide",
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
            bottom: TabBar(
              labelColor: Theme.of(context).indicatorColor,
              tabs: [
                buildAppBarTab("Drivers"),
                buildAppBarTab("Requests"),
              ],
            )),
        body: TabBarView(
          children: <Widget>[
            _buildDriverTab(),
            _buildRequestTab()
          ],
        )
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

  Widget _buildDriverTab() {
    return Center(
        child: ListView(children: [
      InfoCard(
          id: 1,
          destinationName: 'Lazeez',
          departureTime: DateTime.now(),
          address: '23 Lazeez Dr',
          driver: 'Tim Elgersma'),
      InfoCard(
          id: 2,
          destinationName: 'Lazeez',
          departureTime: DateTime.now(),
          address: '23 Lazeez Dr',
          driver: 'Boris Chan'),
      InfoCard(
          id: 3,
          destinationName: 'Lazeez',
          departureTime: DateTime.now(),
          address: '23 Lazeez Dr',
          driver: 'Willa Kong'),
    ]));
  }

  Widget _buildRequestTab() {
    return Center(child: Text("REQUESTS"));
  }

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    return _buildContent();
  }
}
