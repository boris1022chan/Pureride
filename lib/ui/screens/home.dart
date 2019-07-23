import 'package:flutter/material.dart';
import 'package:pureride/ui/screens/request.dart';
import 'package:pureride/ui/theme.dart';
import 'package:pureride/ui/widgets/AppBarTitle.dart';
import 'package:pureride/ui/widgets/info_card.dart';

import '../../models/state.dart';
import '../../state_widget.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  StateModel appState;
  ThemeData appTheme;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  AppBar _buildAppBar() {
    Widget buildAppBarTab(String str) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          str,
          style: buildAppBarStyle(),
        ),
      );
    }

    return AppBar(
        elevation: 2.0,
        title: AppBarTitle(),
        bottom: TabBar(
          labelColor: Theme.of(context).indicatorColor,
          controller: _tabController,
          tabs: [
            buildAppBarTab("Drivers"),
            buildAppBarTab("Requests"),
          ],
        ));
  }

  FloatingActionButton _buildFloatingButton() {
    return _tabController.index == 0
        ? FloatingActionButton(
            shape: StadiumBorder(),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => RequestScreen())),
            backgroundColor: appTheme.primaryColor,
            child: Icon(
              Icons.directions_car,
              size: 20.0,
            ))
        : FloatingActionButton(
            shape: StadiumBorder(),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => RequestScreen())),
            backgroundColor: appTheme.primaryColor,
            child: Icon(
              Icons.note_add,
              size: 20.0,
            ),
          );
  }

  Scaffold _buildTabView({Widget body}) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: body,
      floatingActionButton: _buildFloatingButton(),
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
      return _buildTabView(
          body: TabBarView(
        controller: _tabController,
        children: <Widget>[_buildDriverTab(), _buildRequestTab()],
      ));
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
          driver: 'Tim Elgersma',
          taggerAlongers: <String>[],
          type: 0),
      InfoCard(
          id: 2,
          destinationName: 'Lazeez',
          departureTime: DateTime.now(),
          address: '23 Lazeez Dr',
          driver: 'Boris Chan',
          taggerAlongers: <String>[],
          type: 0),
      InfoCard(
          id: 3,
          destinationName: 'Lazeez',
          departureTime: DateTime.now(),
          address: '23 Lazeez Dr',
          driver: 'Willa Kong',
          taggerAlongers: <String>[],
          type: 0),
    ]));
  }

  Widget _buildRequestTab() {
    return Center(
        child: ListView(children: [
      InfoCard(
          id: 4,
          destinationName: 'Lazeez',
          departureTime: DateTime.now(),
          address: '23 Lazeez Dr',
          driver: '',
          taggerAlongers: ['Dev Monkey1'],
          type: 1),
      InfoCard(
          id: 5,
          destinationName: 'Lazeez',
          departureTime: DateTime.now(),
          address: '23 Lazeez Dr',
          driver: '',
          taggerAlongers: ['Dev Monkey2'],
          type: 1),
      InfoCard(
          id: 6,
          destinationName: 'Lazeez',
          departureTime: DateTime.now(),
          address: '23 Lazeez Dr',
          driver: '',
          taggerAlongers: ['Dev Monkey3'],
          type: 1),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    appTheme = Theme.of(context);
    return _buildContent();
  }
}
