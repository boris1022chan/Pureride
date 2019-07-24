import 'package:flutter/material.dart';
import 'package:pureride/state_widget.dart';
import 'package:pureride/ui/screens/login.dart';
import 'package:pureride/ui/widgets/AppBarTitle.dart';
import 'package:pureride/ui/widgets/google_sign_in_button.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout"),
                onTap: () {
                  StateWidget.of(context).Logout();
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
