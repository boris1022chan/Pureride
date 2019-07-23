import 'package:flutter/material.dart';
import 'package:pureride/ui/widgets/full_screen_info_card.dart';

class InfoCard extends StatelessWidget {
  final int id;
  final String destinationName;
  final String address;
  final TimeOfDay departureTime;

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
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: MediaQuery.of(context).devicePixelRatio,
                  child:
                      Image.network("https://picsum.photos/485/384?image=$id"),
                ),
                Material(
                  child: ListTile(
                    title: Text("Driving to $destinationName"),
                    subtitle: Text("Leaving at ${departureTime.hourOfPeriod}:${departureTime.minute}${departureTime.period.index == 0 ? "a" : "p"}")
                  ),
                ),
                Row(
                  children: <Widget>[
                    AddMeButton(id: this.id),
                    MessageButton(id: this.id)
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                )
              ],
            ),
            Positioned(
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
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddMeButton extends StatelessWidget {
  final int id;

  const AddMeButton({Key key, this.id}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(content: Text("Added yourself"));

        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Icon(Icons.person_add)
    );
  }
}

class MessageButton extends StatelessWidget {
  final int id;

  const MessageButton({Key key, this.id}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(content: Text("Tapped Message"));

        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Icon(Icons.message)
    );
  }
}