import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DepartText extends StatefulWidget {
  DepartText({ Key key }) : super(key: key);
  @override
  DepartTextState createState() => new DepartTextState();
}

class DepartTextState extends State<DepartText> {
  TimeOfDay _time = new TimeOfDay.now();
  DateTime _date = DateTime.now();
  String _departText = "";
  TimeOfDay get departTime => _time;
  DateTime get departDate => _date;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _departText = "${new DateFormat('yyyy-MM-dd').format(_date)}, ${MaterialLocalizations.of(context).formatTimeOfDay(_time)}";
    });
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