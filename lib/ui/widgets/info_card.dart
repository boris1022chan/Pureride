import 'package:flutter/material.dart';
import 'package:pureride/models/drive_info.dart';
import 'package:pureride/ui/widgets/buttons.dart';
import 'package:pureride/ui/widgets/full_screen_info_card.dart';

class InfoCard extends StatelessWidget {
  final int id;
  final DriveInfo driveInfo;
  final String email;

  const InfoCard({Key key, this.id, this.driveInfo, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget textDescription = createText(context, driveInfo, 14, 12);
    final Widget buttonBar = createButtonBar(id, context, email, this.driveInfo);

    return Hero(
        tag: 'hero$id-card',
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: <Widget>[
              textDescription,
              createInkwell(context, buttonBar),
              buttonBar
            ],
          ),
        ));
  }

  Positioned createInkwell(BuildContext context, Widget buttonBar) {
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
                    return new Scaffold(
                      body: FullScreenInfoCard(
                        id: id,
                        context: context,
                        driveInfo: driveInfo,
                        email: email
                      )
                    );
                  },
                ),
              );
            },
          )),
    );
  }
}
