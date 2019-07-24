import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:pureride/models/drive_info.dart';
import 'package:pureride/ui/widgets/add_me_btn.dart';

Align createButtonBar(id, context, email) {
  return Align(
      alignment: Alignment.bottomRight,
      child: ButtonTheme.bar(
        child: new ButtonBar(
          alignment: MainAxisAlignment.end,
          children: <Widget>[
            AddMeButton(id: id),
            createMessageButton(id, context, email)
          ],
        ),
      ));
}

Align createText(BuildContext context, DriveInfo driveInfo, double titleSize,
    double subtitleSize) {
  if (driveInfo.isOffer) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        child: ListTile(
            title: Text("Driving to ${driveInfo.destinationName}",
                style: TextStyle(fontSize: titleSize)),
            subtitle: Text(
                "${driveInfo.driver} is leaving at ${DateFormat("jm").format(driveInfo.departureTime)}",
                style: TextStyle(fontSize: subtitleSize))),
      ),
    );
  } else {
    String requestor = driveInfo.taggerAlongers.elementAt(0);
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
          child: ListTile(
              title: Text(
                  "$requestor wants a drive to ${driveInfo.destinationName}",
                  style: TextStyle(fontSize: titleSize)),
              subtitle: Text(
                  "Planning to leave at ${DateFormat("jm").format(driveInfo.departureTime)}",
                  style: TextStyle(fontSize: subtitleSize)))),
    );
  }
}

Widget createAddMeButton(int id, BuildContext context) {
  return FlatButton(
    child: Icon(
      Icons.person_add,
      color: Colors.white,
    ),
    color: Color.fromRGBO(68, 153, 213, 1.0),
    shape: CircleBorder(),
    onPressed: () {
      Scaffold.of(context).hideCurrentSnackBar();
      final snackbar = SnackBar(
        content: Text('Added yourself!')
      );
      Scaffold.of(context).showSnackBar(snackbar);
    },
  );
}

Widget createMessageButton(int id, BuildContext context, String email) {
  return FlatButton(
    child: Icon(
      Icons.message,
      color: Colors.white,
    ),
    color: Color.fromRGBO(68, 153, 213, 1.0),
    shape: CircleBorder(),
    onPressed: () => _pressedMessageButton(context, email)
  );
}

void _pressedMessageButton(BuildContext context, String email) async {
  String url = 'mailto:' + email;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }

  Scaffold.of(context).hideCurrentSnackBar();
  final snackbar = SnackBar(
    content: Text('Messaged!'),
  );
  Scaffold.of(context).showSnackBar(snackbar);
}
