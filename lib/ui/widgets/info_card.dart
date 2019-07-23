import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pureride/ui/widgets/full_screen_info_card.dart';

class InfoCard extends StatelessWidget {
  final int id;
  final String destinationName;
  final String address;
  final DateTime departureTime;

  const InfoCard(
      {Key key,
      this.id,
      this.destinationName,
      this.address,
      this.departureTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "card$id",
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
            createText(context),
            createInkwell(context),
            createButtonBar(context)
          ],
        ),
      ),
    );
  }

  Align createButtonBar(context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ButtonTheme.bar(
        child: new ButtonBar(
          alignment: MainAxisAlignment.end,
          children: <Widget>[AddMeButton(id: id), MessageButton(id: id)],
        ),
      )
    );
  }

  Align createText(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        child: ListTile(
            title: Text("Driving to $destinationName"),
            subtitle: Text(
                "Leaving at ${DateFormat("jm").format(this.departureTime)}")),
      ),
    );
  }

  Positioned createInkwell(BuildContext context) {
    return Positioned(
      left: 0.0,
      top: 0.0,
      bottom: 0.0,
      right: 0.0,
      child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () async {
              await Future.delayed(Duration(milliseconds: 200));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return new FullScreenInfoCard(id: id);
                  },
                ),
              );
            },
          )),
    );
  }
}

class AddMeButton extends StatelessWidget {
  final int id;

  const AddMeButton({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class MessageButton extends StatelessWidget {
  final int id;

  const MessageButton({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
