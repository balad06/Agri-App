import 'package:agri_app/data.dart';
import 'package:agri_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/alarm_info.dart';
import '../../data.dart';
import 'package:dotted_border/dotted_border.dart';
import '../model/alarm_helper.dart';

class AlarmPage extends StatefulWidget {
  static const id = 'alarms';
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  DateTime _alarmTime;
  String _alarmTimeString;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>> _alarms;
  int i;

    @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(),
          drawer: MainDrawer(),
          body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Alarm',
              style: TextStyle(
                  // fontFamily: 'avenir',
                  fontWeight: FontWeight.w700,
                  fontSize: 24),
            ),
            Expanded(
              child: FutureBuilder<List<AlarmInfo>>(
                future: _alarms,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return ListView(
                      children: snapshot.data.map<Widget>((alarm) {
                        var alarmTime =
                            DateFormat('hh:mm aa').format(alarm.alarmtime);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 32),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.label,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        alarm.descrption,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'avenir'),
                                      ),
                                    ],
                                  ),
                                  Switch(
                                    onChanged: (bool value) {},
                                    value: true,
                                    activeColor: Colors.white,
                                  ),
                                ],
                              ),
                              Text(
                                'Mon-Fri',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'avenir'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    alarmTime,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.white,
                                    onPressed: () {
                                      _alarmHelper.delete(alarm.id);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).followedBy([
                        if (alarms.length < 5)
                          DottedBorder(
                            strokeWidth: 2,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(24),
                            dashPattern: [5, 4],
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                              ),
                              child: FlatButton(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                onPressed: () {
                                  _alarmTimeString =
                                      DateFormat('HH:mm').format(DateTime.now());
                                  showModalBottomSheet(
                                    useRootNavigator: true,
                                    context: context,
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24),
                                      ),
                                    ),
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setModalState) {
                                          return Container(
                                            padding: const EdgeInsets.all(32),
                                            child: Column(
                                              children: [
                                                FlatButton(
                                                  onPressed: () async {
                                                    var selectedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                    );
                                                    if (selectedTime != null) {
                                                      final now = DateTime.now();
                                                      var selectedDateTime =
                                                          DateTime(
                                                              now.year,
                                                              now.month,
                                                              now.day,
                                                              selectedTime.hour,
                                                              selectedTime
                                                                  .minute);
                                                      _alarmTime =
                                                          selectedDateTime;
                                                      setModalState(() {
                                                        _alarmTimeString =
                                                            selectedTime
                                                                .toString();
                                                      });
                                                    }
                                                  },
                                                  child: Text(
                                                    _alarmTimeString,
                                                    style:
                                                        TextStyle(fontSize: 32),
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Text('Repeat'),
                                                  trailing: Icon(
                                                      Icons.arrow_forward_ios),
                                                ),
                                                ListTile(
                                                  title: Text('Sound'),
                                                  trailing: Icon(
                                                      Icons.arrow_forward_ios),
                                                ),
                                                ListTile(
                                                  title: Text('Title'),
                                                  trailing: Icon(
                                                      Icons.arrow_forward_ios),
                                                ),
                                                FloatingActionButton.extended(
                                                  onPressed: () async {
                                                    DateTime
                                                        scheduleAlarmDateTime;
                                                    if (_alarmTime
                                                        .isAfter(DateTime.now()))
                                                      scheduleAlarmDateTime =
                                                          _alarmTime;
                                                    else
                                                      scheduleAlarmDateTime =
                                                          _alarmTime.add(
                                                              Duration(days: 1));

                                                    var alarmInfo = AlarmInfo(
                                                      alarmtime:
                                                          scheduleAlarmDateTime,
                                                      descrption: 'alarm',
                                                    );
                                                    _alarmHelper
                                                        .insertAlarm(alarmInfo);
                                                    // scheduleAlarm(
                                                    //     scheduleAlarmDateTime);
                                                  },
                                                  icon: Icon(Icons.alarm),
                                                  label: Text('Save'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                  // scheduleAlarm();
                                },
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/add_alarm.png',
                                      scale: 1.5,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Add Alarm',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'avenir'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        else
                          Text('Only 5 alarms allowed!'),
                      ]).toList(),
                    );
                  return Center(
                    child: Text(
                      'Loading..',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }}