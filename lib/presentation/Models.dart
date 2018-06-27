


class ModelTimer {
  int timeStart = 0;
  int timeSec = 0;
  TYPE type = TYPE.EMPTY;
  TIME_INTERVAL timeInterval = TIME_INTERVAL.NORMAL;
  int setCount = 0;
  int cycleCount = 0;

}

class ModelHistory   {
  String userName = "";
  int time = 0;
  int workTime = 0;
  int setCount = 0;
  int restTime = 0;
  int cycleCount = 0;
}


enum TIME_INTERVAL {
  START,
  END,
  NORMAL
}

enum TYPE {
  EMPTY,
  PREPARATION_TIME,
  WORK_TIME,
  REST_TIME,
  REST_BETWEEN_SETS_COUNT
}