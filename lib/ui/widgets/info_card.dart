import 'package:flutter/material.dart';
import 'package:pureride/ui/widgets/buttons.dart';
import 'package:pureride/ui/widgets/full_screen_info_card.dart';

class InfoCard extends StatelessWidget {
  final int id;
  final String destinationName;
  final String address;
  final DateTime departureTime;
  final String driver;

  const InfoCard(
      {Key key,
      this.id,
      this.destinationName,
      this.address,
      this.departureTime,
      this.driver})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Widget textDescription = createText(context, destinationName, departureTime, driver);
    final Widget buttonBar = createButtonBar(id, context);

    return Hero(
      tag: "card$id",
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
            textDescription,
            createInkwell(context, textDescription, buttonBar),
            buttonBar
          ],
        ),
      ),
    );
  }

  Positioned createInkwell(BuildContext context, Widget textDescription, Widget buttonBar) {
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
                    return new FullScreenInfoCard(
                        id: id,
                        context: context,
                        destinationName: this.destinationName,
                        address: this.address,
                        departureTime: this.departureTime,
                        driver: this.driver,
                        textDescription: textDescription,
                        buttonBar: buttonBar);
                  },
                ),
              );
            },
          )),
    );
  }
}
