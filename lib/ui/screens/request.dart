import 'package:flutter/material.dart';
import 'package:pureride/ui/widgets/AppBarTitle.dart';
import 'package:pureride/ui/widgets/departText.dart';
import 'package:pureride/service/firebase_firestore_service_req.dart';

final key = new GlobalKey<DepartTextState>();

class RequestScreen extends StatelessWidget {
  static GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String _name, _email, _destination;
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppBarTitle(),),
      body: Card(
        child: Padding(padding: EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name:'
                    ),
                    onSaved: (input) => _name = input,
                    validator: (input) {
                      if (input.isEmpty)
                        return "Not a valid name";
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email:'
                    ),
                    validator: (input) {
                      if (input.isEmpty || !input.contains('@'))
                        return "Not a valid email";
                      return null;
                    },
                    onSaved: (input) => _email = input,
                  ),
                  new Text('\n'),
                  Container(
                    height: 100,
                    child: new DepartText(key: key)
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Destination:'
                    ),
                    onSaved: (input) => _destination = input,
                    validator: (input) {
                      if (input.isEmpty)
                        return "Not a valid destination";
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget> [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () => _submit(key.currentState.departDate, key.currentState.departTime, context),
                          child: Text('Request'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              )
            ],
          )
        )) 
      ),
    );
  }

  void _submit(DateTime departDate, TimeOfDay departTime, BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      /*
      print(departDate.toString());
      print(departTime.toString());
      print(_name);
      print(_email);
      print(_destination);
      */
      DateTime dep = new DateTime(departDate.year, departDate.month, departDate.day, departTime.hour, departTime.minute);
      db.createNote( _destination, _destination, dep, _name, [], false).then((_) {
        Navigator.pop(context);
      });

    }
    // TODO: Firestore writing
  }
}