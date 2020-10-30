import 'package:agri_app/reminder/global_bloc.dart';
import 'package:agri_app/widgets/appbar.dart';
import 'package:agri_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:agri_app/reminder/models/medicine.dart';
import 'package:agri_app/reminder/ui/medicine_details.dart';
import 'package:agri_app/reminder/ui/new_entry.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const id = '/homepage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      appBar: Topbar('Reminder', []),
      drawer: MainDrawer(),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Flexible(
              flex: 3,
              child: TopContainer(),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 7,
              child: Provider<GlobalBloc>.value(
                child: BottomContainer(),
                value: _globalBloc,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewEntry(),
            ),
          );
        },
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.only(
          //     bottom: 10,
          //   ),
          //   child: Text(
          //     "Planminder",
          //     style: TextStyle(
          //       fontSize: 40,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Center(
              child: Text(
                "Number of Planminders",
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          StreamBuilder<List<Plant>>(
            stream: globalBloc.plantList$,
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 5),
                child: Center(
                  child: Text(
                    !snapshot.hasData ? '0' : snapshot.data.length.toString(),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BottomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder<List<Plant>>(
      stream: _globalBloc.plantList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.data.length == 0) {
          return Container(
            color: Color(0xFFF6F8FC),
            child: Center(
              child: Text(
                "Press + to add a Planminder",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFFC9C9C9),
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          return Container(
            color: Color(0xFFF6F8FC),
            child: GridView.builder(
              padding: EdgeInsets.only(top: 12),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return PlantCard(snapshot.data[index]);
              },
            ),
          );
        }
      },
    );
  }
}

class PlantCard extends StatelessWidget {
  final Plant plant;

  PlantCard(this.plant);

  Hero makeIcon(double size) {
    if (plant.plantName == "water") {
      return Hero(
        tag: plant.plantName + plant.plantType,
        child: Icon(
          Icons.ac_unit,
          color: Colors.lightGreen,
          size: size,
        ),
      );
    } else if (plant.plantName == "bugz") {
      return Hero(
        tag: plant.plantName + plant.plantType,
        child: Icon(
          Icons.bug_report,
          color: Colors.lightGreen,
          size: size,
        ),
      );
    } else if (plant.plantName == "fertilizers") {
      return Hero(
        tag: plant.plantName + plant.plantType,
        child: Icon(
          Icons.album,
          color: Colors.lightGreen,
          size: size,
        ),
      );
    } else if (plant.plantName == "diffrent") {
      return Hero(
        tag: plant.plantName + plant.plantType,
        child: Icon(
          Icons.developer_mode,
          color: Colors.lightGreen,
          size: size,
        ),
      );
    }
    return Hero(
      tag: plant.plantName + plant.plantType,
      child: Icon(
        Icons.alarm,
        color: Colors.lightGreen,
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: InkWell(
        highlightColor: Colors.white,
        splashColor: Colors.grey,
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder<Null>(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: PlantDetails(plant),
                      );
                    });
              },
              transitionDuration: Duration(milliseconds: 500),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                makeIcon(50.0),
                Hero(
                  tag: plant.plantName,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      plant.plantName,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Text(
                  plant.interval == 1
                      ? "Every " + plant.interval.toString() + " hour"
                      : "Every " + plant.interval.toString() + " hours",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
