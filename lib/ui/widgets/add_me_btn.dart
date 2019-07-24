import 'package:flutter/material.dart';

Widget createAddMeButton(int id, BuildContext context) {
  return FlatButton(
    child: Icon(
      Icons.person_add,
      color: Colors.white,
    ),
    color: Color.fromRGBO(68, 153, 213, 1.0),
    shape: CircleBorder(),
    onPressed: () {
      Scaffold.of(context).hideCurrentSnackBar();
      final snackbar = SnackBar(content: Text('Added yourself!'));
      Scaffold.of(context).showSnackBar(snackbar);
    },
  );
}

class AddMeButton extends StatefulWidget {
  final bool isSelected;
  final int id;

  const AddMeButton({this.id, this.isSelected = false}) : super();

  @override
  _AddMeButtonState createState() => _AddMeButtonState(isSelected: isSelected);
}

class _AddMeButtonState extends State<AddMeButton> {
  bool isSelected = false;
  final Color selectedColor = Colors.red;
  final Color unselectedColor = Colors.blue;

  _AddMeButtonState({this.isSelected});

  @override
  Widget build(BuildContext context) {
    print(this.isSelected);
    return FlatButton(
      child: Icon(
        Icons.person_add,
        color: Colors.white,
      ),
      color: this.isSelected ? this.selectedColor : this.unselectedColor,
      shape: CircleBorder(),
      onPressed: () {
        setState(() => this.isSelected = !this.isSelected);
        Scaffold.of(context).hideCurrentSnackBar();
        final snackbar = SnackBar(content: Text(this.isSelected ? 'Added yourself as a rider' : 'Removed yourself as a rider' ));
        Scaffold.of(context).showSnackBar(snackbar);
      },
    );
  }
}
