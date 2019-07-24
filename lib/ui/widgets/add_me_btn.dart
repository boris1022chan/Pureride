import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pureride/models/drive_info.dart';
import 'package:pureride/models/state.dart';
import 'package:pureride/state_widget.dart';

class AddMeButton extends StatefulWidget {
  final int id;
  final DriveInfo driveInfo;

  const AddMeButton({this.id, this.driveInfo}) : super();

  @override
  _AddMeButtonState createState() =>
      _AddMeButtonState(id: id, driveInfo: driveInfo);
}

class _AddMeButtonState extends State<AddMeButton> {
  bool isSelected = false;
  int id;
  final Color selectedColor = Colors.red;
  final Color unselectedColor = Colors.blue;
  final Color disabledColor = Colors.grey[700];
  final DriveInfo driveInfo;

  _AddMeButtonState({this.id, this.driveInfo});

  Function updateSelf(BuildContext context) {
    void innerFn() {
      int selectedId = StateWidget.of(context).state.selectedId;
      if (this.id != selectedId) {
        setState(() {
          this.isSelected = false;
        });
      }
    }

    return innerFn;
  }

  int _getSeatsTaken(String username) {
    // need to update instantly (don't wait for DB to update)
    List<dynamic> taggerAlongers = this.driveInfo.taggerAlongers ?? [];
    if (taggerAlongers.indexOf(username) == -1) {
      // user is not in taggerAlongers
      // add 1 to length if we should be
      return taggerAlongers.length + (this.isSelected ? 1 : 0);
    } else {
      // user is in taggerAlongers
      // subtract 1 from length if we shouldn't be
      return taggerAlongers.length - (this.isSelected ? 0 : 1);
    }
  }

  int _getSeatsRemaining(String username) {
    return max(0, this.driveInfo.totalSeats - this._getSeatsTaken(username));
  }

  String _getSeatsRemainingText(String username) {
    int seats = this._getSeatsRemaining(username);
    return "$seats seat${seats == 1 ? '' : 's'}";
  }

  @override
  Widget build(BuildContext context) {
    StateModel appState = StateWidget.of(context).state;
    this.isSelected = (appState.selectedId == this.id);

    appState.addMeSubscribers[this.id] = this.updateSelf(context);

    return Stack(children: <Widget>[
      FlatButton(
        child: Icon(
          this.isSelected ? Icons.person : Icons.person_add,
          color: Colors.white,
        ),
        color: (this.id == appState.selectedId)
            ? this.selectedColor
            : (this._getSeatsRemaining(appState.username) > 0
                ? unselectedColor
                : disabledColor),
        shape: CircleBorder(),
        onPressed: () {
          if (this.isSelected ||
              this._getSeatsRemaining(appState.username) > 0) {
            // only update button if we have some action to perform when clicking
            this.isSelected = !this.isSelected;
            setState(() {
              if (this.isSelected) {
                appState.selectedId = this.id;
              } else if (appState.selectedId == this.id) {
                appState.selectedId = null; // declaim only if we had it
              }
              appState.updateAddMeSubscribers(); // deselect all others
            });
          }
          Scaffold.of(context).hideCurrentSnackBar();
          final snackbar = SnackBar(
              content: Text(this.isSelected
                  ? 'Added yourself as a rider'
                  : (this._getSeatsRemaining(appState.username) > 0
                      ? 'Removed yourself as a rider'
                      : 'This car is full!')));
          Scaffold.of(context).showSnackBar(snackbar);
        },
      ),
      Positioned(
          child: IgnorePointer(
        child: Container(
          padding: EdgeInsets.all(3),
          child: Text(this._getSeatsRemainingText(appState.username),
              style: TextStyle(fontSize: 10, color: Colors.grey[100])),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ))
    ]);
  }
}
