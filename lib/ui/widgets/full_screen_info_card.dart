import 'package:flutter/material.dart';
import 'package:pureride/models/drive_info.dart';
import 'package:pureride/ui/widgets/buttons.dart';

class FullScreenInfoCard extends StatelessWidget {
  final int id;
  final BuildContext context;
  final DriveInfo driveInfo;
  final Widget buttonBar;

  const FullScreenInfoCard(
      {Key key, this.id, this.context, this.driveInfo, this.buttonBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Hero(
        tag: 'hero$id-card',
        child: Material(
          child: ListView(
            children: <Widget>[
              // Container(height: appBar.preferredSize.height),
              Container(
                child: createText(context, driveInfo, 18, 14),
              ),
              IgnorePointer(
                child: ConstrainedBox(
                    constraints: BoxConstraints.loose(Size(
                        mediaQuery.size.width * 0.8,
                        mediaQuery.size.height * 0.75)),
                    // margin: EdgeInsets.only(top: 100, left: 50),
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                          ListTile(
                            title: Text("Riders"),
                            subtitle: Text(
                                "Willa Kong\nMarc Xu\nOlivia Zhou\nBoris Chan\nTimothy Elgersma"),
                            isThreeLine: true,
                          ),
                          ListTile(
                            title: Text("Duration"),
                            subtitle: Text("15 minutes"),
                          )
                        ],
                      ),
                      // padding: EdgeInsets.only(top: 80)
                    )),
              ),
              buttonBar
            ],
          ),
        ));
  }
}
