import 'package:agri_app/data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import'../alarm/alarm_info.dart';
import '../../data.dart';
class AlarmPage extends StatefulWidget {
  static const id = 'alarms';
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  DateTime _alarmTime;
  String _alarmTimeString;
  String title;
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(
                Icons.keyboard_arrow_left,
              ),
            ),
            Text('Back',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: .5,
              child:  Image(
              image: AssetImage('assets/images/agriculture.jpg'),
              height: double.infinity,
              width: MediaQuery.of(context).size.height,
              fit: BoxFit.fitHeight,
            ),
            ),
            Column(children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Reminders',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: ListView(
                    children: alarms.map((alarms) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.label,
                                      color: Colors.white, size: 24),
                                  Text(
                                    alarms.descrption,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Switch(
                                value: true,
                                onChanged: (bool value) {},
                                activeColor: Colors.white,
                              )
                            ],
                          ),
                          Row(children: [
                            Text(
                              'Mon-Fri',
                              style: TextStyle(color: Colors.white),
                            ),
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                alarms.alarmtime.toIso8601String(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete,
                                      size: 30, color: Colors.white),
                                  onPressed: null)
                            ],
                          )
                        ]),
                      ),
                    ),
                  );
                }).followedBy([
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: FlatButton(
                            onPressed:() {
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
                                                    // selectedTime=DateFormat('HH:mm').format(DateTime.now());
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
                                                  // _alarmHelper
                                                  //     .insertAlarm(alarmInfo);
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
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.add,
                                    size: 36,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Add Alarm',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24),
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
                ]).toList()),
              ),
            ]),
            Positioned(top: 10, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
