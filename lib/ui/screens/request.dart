import 'dart:math';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:pureride/ui/widgets/AppBarTitle.dart';

final key = new GlobalKey<_DepartTextState>();

class DepartText extends StatefulWidget {
  DepartText({ Key key }) : super(key: key);
  @override
  _DepartTextState createState() => new _DepartTextState();
}

class _DepartTextState extends State<DepartText> {
  TimeOfDay _time = new TimeOfDay.now();
  DateTime _date = DateTime.now();
  String _departText = "(Please select a date and time)";
  TimeOfDay get departTime => _time;
  DateTime get departDate => _date;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                child: Text(
                  "Time of Departure: " + _departText,
                ),
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new RaisedButton(
                    child: new Text('Select Date'),
                    onPressed: (){_selectDate(context);},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new RaisedButton(
                    child: new Text('Select Time'),
                    onPressed: (){_selectTime(context);},
                  ),
                ),
            ],)
          ],
        )
      )
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101)
    );
    if(picked != null && picked != _date){
      _date = picked;
      setState(() {
        _departText = "${new DateFormat('yyyy-MM-dd').format(_date)}, ${MaterialLocalizations.of(context).formatTimeOfDay(_time)}";
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time
    );
    if(picked != null && picked != _time){
      _time = picked;
      setState(() {
        _departText = "${new DateFormat('yyyy-MM-dd').format(_date)}, ${MaterialLocalizations.of(context).formatTimeOfDay(_time)}";
      });
    }
  }
}

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
                    child: new DepartText()
                  ),
                  TextFormField(
                    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
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
    // TODO: Firestore writing
  }
}