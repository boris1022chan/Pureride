import 'package:flutter/material.dart';
import 'package:pureride/ui/widgets/buttons.dart';

class FullScreenInfoCard extends StatelessWidget {
  final int id;
  final BuildContext context;
  final String destinationName;
  final String address;
  final DateTime departureTime;
  final String driver;
  final List taggerAlongers;
  final int type;

  const FullScreenInfoCard(
      {Key key,
      this.id,
      this.context,
      this.destinationName,
      this.address,
      this.departureTime,
      this.driver,
      this.taggerAlongers,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appBar = new AppBar(
      primary: true,
      leading: IconTheme(
          data: IconThemeData(color: Colors.white), child: CloseButton()),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.4),
              Colors.black.withOpacity(0.1),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Stack(children: <Widget>[
      Hero(
        tag: "card$id",
        child: Material(
          child: ListView(
            children: <Widget>[
              Container(height: appBar.preferredSize.height),
              createText(this.context, this.destinationName, this.departureTime,
                  this.driver, this.type, this.taggerAlongers),
              createButtonBar(this.id, this.context)
            ],
          ),
        ),
      ),
      Column(
        children: <Widget>[
          Container(
            height: mediaQuery.padding.top,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: appBar.preferredSize.height),
            child: appBar,
          )
        ],
      ),
    ]);
  }
}
