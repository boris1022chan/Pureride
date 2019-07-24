import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:pureride/ui/widgets/AppBarTitle.dart';
import 'package:pureride/ui/widgets/departText.dart';

final key = new GlobalKey<DepartTextState>();

class RequestScreen extends StatelessWidget {
  static GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String _name, _destination;
  int _seatsAvailale;
  
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
                    //validator: (input) => !input.contains('@') ? 'Not a valid Name.',
                    onSaved: (input) => _name = input,
                  ),
                  new Text('\n'),
                  Container(
                    height: 100,
                    child: new DepartText(key: key)
                  ),
                  TextFormField(
                    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Available Seats:'
                    ),
                    //validator: (input) => !input.contains('@') ? 'Not a valid Name.',
                    onSaved: (input) => _seatsAvailale = int.parse(input),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Destination:'
                    ),
                    //validator: (input) => !input.contains('@') ? 'Not a valid Name.',
                    onSaved: (input) => _destination = input,
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