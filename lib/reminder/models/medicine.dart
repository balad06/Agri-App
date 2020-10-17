class Plant {
  final List<dynamic> notificationIDs;
  final String plantName;
  final int dosage;
  final String plantType;
  final int interval;
  final String startTime;

  Plant({
    this.notificationIDs,
    this.plantName,
    this.dosage,
    this.plantType,
    this.startTime,
    this.interval,
  });

  String get getName => plantName;
  int get getDosage => dosage;
  String get getType => plantType;
  int get getInterval => interval;
  String get getStartTime => startTime;
  List<dynamic> get getIDs => notificationIDs;

  Map<String, dynamic> toJson() {
    return {
      "ids": this.notificationIDs,
      "name": this.plantName,
      "dosage": this.dosage,
      "type": this.plantType,
      "interval": this.interval,
      "start": this.startTime,
    };
  }

  factory Plant.fromJson(Map<String, dynamic> parsedJson) {
    return Plant(
      notificationIDs: parsedJson['ids'],
      plantName: parsedJson['name'],
      dosage: parsedJson['dosage'],
      plantType: parsedJson['type'],
      interval: parsedJson['interval'],
      startTime: parsedJson['start'],
    );
  }
}
