import 'package:flutter/cupertino.dart';

class AlarmInfo{
  int id;
  DateTime alarmtime;
  String descrption;
  int isActive;

  AlarmInfo({
    this.id,
    @required this.alarmtime,
    this.descrption,
    this.isActive,
  });
  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
        id: json["id"],
        descrption: json["title"],
        alarmtime: DateTime.parse(json["alarmDateTime"]),
        isActive: json["isPending"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "descrption": descrption,
        "alarmtime": alarmtime.toIso8601String(),
        "isPending": isActive,
      };
}