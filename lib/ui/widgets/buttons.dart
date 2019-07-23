import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Align createButtonBar(id, context) {
  return Align(
      alignment: Alignment.bottomRight,
      child: ButtonTheme.bar(
        child: new ButtonBar(
          alignment: MainAxisAlignment.end,
          children: <Widget>[
            createAddMeButton(id, context),
            createMessageButton(id, context)
          ],
        ),
      ));
}

Align createText(
    BuildContext context,
    String destinationName,
    DateTime departureTime,
    String driver,
    int type,
    List taggerAlonger,
    double titleSize,
    double subtitleSize) {
  if (type == 0) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        child: ListTile(
            title: Text("Driving to $destinationName",
                style: TextStyle(fontSize: titleSize)),
            subtitle: Text(
                "$driver is leaving at ${DateFormat("jm").format(departureTime)}",
                style: TextStyle(fontSize: subtitleSize))),
      ),
    );
  } else {
    String requestor = taggerAlonger.elementAt(0);
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
          child: ListTile(
              title: Text("$requestor wants a drive to $destinationName",
                  style: TextStyle(fontSize: titleSize)),
              subtitle: Text(
                  "Planning to leave at ${DateFormat("jm").format(departureTime)}",
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
      final snackbar = SnackBar(
        content: Text('Added yourself!'),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    },
  );
}

Widget createMessageButton(int id, BuildContext context) {
  return FlatButton(
    child: Icon(
      Icons.message,
      color: Colors.white,
    ),
    color: Color.fromRGBO(68, 153, 213, 1.0),
    shape: CircleBorder(),
    onPressed: () {
      final snackbar = SnackBar(
        content: Text('Messaged!'),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    },
  );
}
