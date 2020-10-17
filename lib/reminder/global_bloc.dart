import 'dart:convert';
import './models/medicine.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalBloc {
  BehaviorSubject<List<Plant>> _plantList$;
  BehaviorSubject<List<Plant>> get plantList$ => _plantList$;

  GlobalBloc() {
    _plantList$ = BehaviorSubject<List<Plant>>.seeded([]);
    makePlantList();
  }


  Future removePlant(Plant tobeRemoved) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> plantJsonList = [];

    var blocList = _plantList$.value;
    blocList.removeWhere(
        (plant) => plant.plantName == tobeRemoved.plantName);

    for (int i = 0; i < (24 / tobeRemoved.interval).floor(); i++) {
      flutterLocalNotificationsPlugin
          .cancel(int.parse(tobeRemoved.notificationIDs[i]));
    }
    if (blocList.length != 0) {
      for (var blocMedicine in blocList) {
        String medicineJson = jsonEncode(blocMedicine.toJson());
        plantJsonList.add(medicineJson);
      }
    }
    sharedUser.setStringList('medicines', plantJsonList);
    _plantList$.add(blocList);
  }

  Future updateMedicineList(Plant newMedicine) async {
    var blocList = _plantList$.value;
    blocList.add(newMedicine);
    _plantList$.add(blocList);
    Map<String, dynamic> tempMap = newMedicine.toJson();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    String newMedicineJson = jsonEncode(tempMap);
    List<String> medicineJsonList = [];
    if (sharedUser.getStringList('medicines') == null) {
      medicineJsonList.add(newMedicineJson);
    } else {
      medicineJsonList = sharedUser.getStringList('medicines');
      medicineJsonList.add(newMedicineJson);
    }
    sharedUser.setStringList('medicines', medicineJsonList);
  }

  Future makePlantList() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> jsonList = sharedUser.getStringList('medicines');
    List<Plant> prefList = [];
    if (jsonList == null) {
      return;
    } else {
      for (String jsonMedicine in jsonList) {
        Map userMap = jsonDecode(jsonMedicine);
        Plant tempMedicine = Plant.fromJson(userMap);
        prefList.add(tempMedicine);
      }
      _plantList$.add(prefList);
    }
  }

  void dispose() {
    _plantList$.close();
  }
}
