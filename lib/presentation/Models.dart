class ModelTimer {
  int timeStart = 0;
  int maxValue = 0;

  int timeSec = 0;
  TYPE type = TYPE.EMPTY;
  TIME_INTERVAL timeInterval = TIME_INTERVAL.NORMAL;
  int setCount = 0;
  int cycleCount = 0;

  double getPercent() {
    return timeSec.toDouble() /  maxValue.toDouble()*100;
  }
}

class ModelHistory {
  String name = "";
  int time = 0;
  int workTime = 0;
  int setCount = 0;
  int restTime = 0;
  int cycleCount = 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelHistory &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          time == other.time &&
          workTime == other.workTime &&
          setCount == other.setCount &&
          restTime == other.restTime &&
          cycleCount == other.cycleCount;

  @override
  int get hashCode =>
      name.hashCode ^
      time.hashCode ^
      workTime.hashCode ^
      setCount.hashCode ^
      restTime.hashCode ^
      cycleCount.hashCode;

  ModelHistory(
      {this.name,
      this.time,
      this.workTime,
      this.setCount,
      this.restTime,
      this.cycleCount});

  factory ModelHistory.fromJson(Map<String, dynamic> json) {
    return ModelHistory(
        name: json['name'],
        time: json['time'],
        workTime: json['workTime'],
        setCount: json['setCount'],
        restTime: json['restTime'],
        cycleCount: json['cycleCount']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'time': time,
        'workTime': workTime,
        'setCount': setCount,
        'restTime': restTime,
        'cycleCount': cycleCount
      };

  @override
  String toString() {
    return 'ModelHistory{name: $name, time: $time, workTime: $workTime, setCount: $setCount, restTime: $restTime, cycleCount: $cycleCount}';
  }


}

enum TIME_INTERVAL { START, END, NORMAL }

enum TYPE {
  EMPTY,
  PREPARATION_TIME,
  WORK_TIME,
  REST_TIME,
  REST_BETWEEN_SETS_COUNT
}
