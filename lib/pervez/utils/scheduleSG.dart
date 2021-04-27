import 'dart:io';
import 'package:flutter/material.dart';

class ScheduleSG {

  int id;
  String caption;
  String hash;
  DateTime date;
  TimeOfDay time;
  File image;
  String imagePath;
  var timeDiff;
  var completeTime;


  ScheduleSG(int _id, String _caption, String _hash, DateTime _date, TimeOfDay _time, File _image, String _imagePath,var _timeDiff, var _completeTime){
    this.id = _id;
    this.caption = _caption;
    this.hash = _hash;
    this.date = _date;
    this.time = _time;
    this.image = _image;
    this.imagePath = _imagePath;
    this.timeDiff = _timeDiff;
    this.completeTime = _completeTime;
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.caption}, ${this.hash}, ${this.date}, ${this.time}, ${this.image}, ${this.imagePath}, ${this.timeDiff}, ${this.completeTime} }';
  }

  void setState(Null Function() param0) {}
}