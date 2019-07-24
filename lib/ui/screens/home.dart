import 'package:flutter/material.dart';
import 'package:pureride/models/drive_info.dart';
import 'package:pureride/ui/screens/request.dart';
import 'package:pureride/ui/theme.dart';
import 'package:pureride/ui/widgets/AppBarTitle.dart';
import 'package:pureride/ui/widgets/info_card.dart';

import '../../models/state.dart';
import '../../state_widget.dart';
import 'login.dart';

import '../data_demo/listview_note.dart';


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
        child: Text(str),
      );
    }

    return AppBar(
        elevation: 2.0,
        title: AppBarTitle(),
        bottom: TabBar(
          labelStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16.0,
          ),
          labelColor: Theme.of(context).tabBarTheme.labelColor,
          unselectedLabelColor:
              Theme.of(context).tabBarTheme.unselectedLabelColor,
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
        children: <Widget>[            
          ListViewNote(),
          ListViewNote(),
          ],
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
        driveInfo: DriveInfo(
            destinationName: 'Lazeez',
            departureTime: DateTime.now(),
            address: '23 Lazeez Dr',
            driver: 'Tim Elgersma',
            taggerAlongers: <String>[],
            isOffer: true),
      ),
      InfoCard(
          id: 2,
          driveInfo: DriveInfo(
              destinationName: 'Lazeez',
              departureTime: DateTime.now(),
              address: '23 Lazeez Dr',
              driver: 'Boris Chan',
              taggerAlongers: <String>[],
              isOffer: true)),
      InfoCard(
          id: 3,
          driveInfo: DriveInfo(
              destinationName: 'Lazeez',
              departureTime: DateTime.now(),
              address: '23 Lazeez Dr',
              driver: 'Willa Kong',
              taggerAlongers: <String>[],
              isOffer: true)),
    ]));
  }

  Widget _buildRequestTab() {
    return Center(
        child: ListView(children: [
      InfoCard(
          id: 4,
          driveInfo: DriveInfo(
              destinationName: 'Lazeez',
              departureTime: DateTime.now(),
              address: '23 Lazeez Dr',
              driver: '',
              taggerAlongers: ['Dev Monkey1'],
              isOffer: false)),
      InfoCard(
          driveInfo: DriveInfo(
              destinationName: 'Lazeez',
              departureTime: DateTime.now(),
              address: '23 Lazeez Dr',
              driver: '',
              taggerAlongers: ['Dev Monkey2'],
              isOffer: false)),
      InfoCard(
          id: 6,
          driveInfo: DriveInfo(
              destinationName: 'Lazeez',
              departureTime: DateTime.now(),
              address: '23 Lazeez Dr',
              driver: '',
              taggerAlongers: ['Dev Monkey3'],
              isOffer: false)),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    appTheme = Theme.of(context);
    return _buildContent();
  }
}
