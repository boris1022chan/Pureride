import 'package:flutter/material.dart';
import 'package:pureride/models/note.dart';
import 'package:pureride/service/firebase_firestore_service.dart';
 
class NoteScreen extends StatefulWidget {
  final Note note;
  NoteScreen(this.note);
 
  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}
 
 
class _NoteScreenState extends State<NoteScreen> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();
 
  TextEditingController _destinationNameController;
  TextEditingController _addressController;
  TextEditingController _driverController;
 
  @override
  void initState() {
    super.initState();
 
    _destinationNameController = new TextEditingController(text: widget.note.destinationName);
    _addressController = new TextEditingController(text: widget.note.address);
    _driverController = new TextEditingController(text: widget.note.driver);

  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Note')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _destinationNameController,
              decoration: InputDecoration(labelText: 'destinationName'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'address'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),          
            TextField(
              controller: _driverController,
              decoration: InputDecoration(labelText: 'driver'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.note.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.note.id != null) {
                  db
                      .updateNote(
                          Note(widget.note.id, _destinationNameController.text, _addressController.text, DateTime.now(), _driverController.text, widget.note.taggerAlongers, true, 0))
                      .then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  db.createNote( _destinationNameController.text, _addressController.text, DateTime.now(), _driverController.text, [], true,0).then((_) {
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}