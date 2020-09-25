import 'package:flutter/cupertino.dart';

class AlarmInfo{
  DateTime alarmtime;
  String descrption;
  bool isActive;

  AlarmInfo({
    @required this.alarmtime,
    this.descrption
  });
}