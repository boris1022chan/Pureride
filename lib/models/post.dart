import 'package:firebase_database/firebase_database.dart';
 
class Post {
  String _id;
  String _title;
  String _dest;
  int _duration;
  int _capacity;
 
  Note(this._id, this._title, this._dest, this._duration, this._capacity);
 
  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._dest = obj['dest'];
    this._duration = obj['duration'];
    this._capacity = obj['capacity'];
  }
 
  String get id => _id;
  String get title => _title;
  String get dest => _dest;
  int get duration => _duration;
  int get capacity => _capacity;
 
  Note.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _title = snapshot.value['title'];
    _dest = snapshot.value['dest'];
    _duration = snapshot.value['duration'];
    _capacity = snapshot.value['capacity'];
  }
}
