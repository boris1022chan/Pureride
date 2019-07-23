import 'package:flutter/material.dart';

class FullScreenInfoCard extends StatelessWidget {
  final int id;

  const FullScreenInfoCard({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appBar = new AppBar(
      primary: false,
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
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: MediaQuery.of(context).devicePixelRatio,
                child:
                    Image.network("https://picsum.photos/485/384?image=$id"),
              ),
              Material(
                child: ListTile(
                  title: Text("Item $id"),
                  subtitle: Text("This is item #$id"),
                ),
              ),
              Expanded(
                child: Center(child: Text("Some more content goes here!")),
              )
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
