import 'package:flutter/material.dart';
import 'package:pureride/ui/widgets/buttons.dart';
import 'package:pureride/ui/widgets/full_screen_info_card.dart';

class InfoCard extends StatelessWidget {
  final int id;
  final String destinationName;
  final String address;
  final DateTime departureTime;
  final String driver;
  final List taggerAlongers;
  final int type;

  const InfoCard(
      {Key key,
      this.id,
      this.destinationName,
      this.address,
      this.departureTime,
      this.driver,
      this.taggerAlongers,
      this.type})
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
            createText(
                context, this.destinationName, this.departureTime, this.driver, this.type, this.taggerAlongers),
            createInkwell(context),
            createButtonBar(id, context)
          ],
        ),
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
                    return new FullScreenInfoCard(
                        id: id,
                        context: context,
                        destinationName: this.destinationName,
                        address: this.address,
                        departureTime: this.departureTime,
                        driver: this.driver);
                  },
                ),
              );
            },
          )),
    );
  }
}
