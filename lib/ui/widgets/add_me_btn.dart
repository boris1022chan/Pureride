import 'package:flutter/material.dart';
import 'package:pureride/models/state.dart';
import 'package:pureride/state_widget.dart';

class AddMeButton extends StatefulWidget {
  final int id;

  const AddMeButton({this.id}) : super();

  @override
  _AddMeButtonState createState() => _AddMeButtonState(id: id);
}

class _AddMeButtonState extends State<AddMeButton> {
  bool isSelected = false;
  int id;
  final Color selectedColor = Colors.red;
  final Color unselectedColor = Colors.blue;

  _AddMeButtonState({this.id});

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

  @override
  Widget build(BuildContext context) {
    StateModel appState = StateWidget.of(context).state;
    this.isSelected = (appState.selectedId == this.id);

    appState.addMeSubscribers[this.id] = this.updateSelf(context);

    return FlatButton(
      child: Icon(
        this.isSelected ? Icons.person : Icons.person_add,
        color: Colors.white,
      ),
      color: (this.id == appState.selectedId)
          ? this.selectedColor
          : this.unselectedColor,
      shape: CircleBorder(),
      onPressed: () {
        this.isSelected = !this.isSelected;
        setState(() {
          if (this.isSelected) {
            appState.selectedId = this.id;
          } else if (appState.selectedId == this.id) {
            appState.selectedId = null; // declaim only if we had it
          }
          appState.updateAddMeSubscribers(); // deselect all others
        });
        Scaffold.of(context).hideCurrentSnackBar();
        final snackbar = SnackBar(
            content: Text(this.isSelected
                ? 'Added yourself as a rider'
                : 'Removed yourself as a rider'));
        Scaffold.of(context).showSnackBar(snackbar);
      },
    );
  }
}
