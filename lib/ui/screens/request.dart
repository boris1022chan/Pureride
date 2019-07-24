import 'package:flutter/material.dart';
import 'package:pureride/ui/widgets/AppBarTitle.dart';
import 'package:pureride/ui/widgets/departText.dart';

final key = new GlobalKey<DepartTextState>();

class RequestScreen extends StatelessWidget {
  static GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String _name, _email, _destination;

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
                          onPressed: () => _submit(key.currentState.departDate, key.currentState.departTime),
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

  void _submit(DateTime departDate, TimeOfDay departTime) {
    print(departDate.toString());
    print(departTime.toString());
    // TODO: Firestore writing
  }
}