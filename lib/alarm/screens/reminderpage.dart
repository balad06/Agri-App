import 'package:agri_app/alarm/screens/alarm_page.dart';
import 'package:agri_app/alarm/widgets/clockview.dart';
import 'package:agri_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderPage extends StatefulWidget {
  static const String id = '/reminder';
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  var now = DateTime.now();
  var formattedTime = DateFormat('HH:mm').format(DateTime.now());
  var formattedDate = DateFormat('EEE, d MMM').format(DateTime.now());
  var timezoneString =
      DateTime.now().timeZoneOffset.toString().split('.').first;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Water Reminder',
              style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(27),
              ),
            ),
            backgroundColor: Colors.lightGreen,
            elevation: 0.0,
          ),
          drawer: MainDrawer(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              formattedTime,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 42,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: ClockView(),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AlarmPage.id);
                      },
                      elevation: 2.0,
                      fillColor: Colors.lightGreen,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
