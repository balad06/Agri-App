import './alarm/alarm/alarm_info.dart';

List<AlarmInfo> alarms = [
  AlarmInfo(
      alarmtime: DateTime.now().add(Duration(hours: 1)), descrption: 'Office'),
  AlarmInfo(alarmtime: DateTime.now().add(Duration(hours: 2)),descrption: 'school')
];
