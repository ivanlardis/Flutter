


abstract class ITrainingView {
void show(TrainingModel model);
}

class TrainingPresenter{


  ITrainingView  iTrainingView;
  TrainingPresenter(this.iTrainingView);


  void startTrain(){

    print("startTrain ");
    var a=new TrainingModel();
    a.set=34;
    iTrainingView.show(a);
  }

  void stopTrain(){
    print("stopTrain ");
    var a=new TrainingModel();
    a.set=4;
    iTrainingView.show(a);

  }


}

class TrainingModel{
  int _set=0;
  String _type="";
  int _cycle=0;
  int _time=0;

  int get set => _set;

  set set(int value) {
    _set = value;
  }


  String get type => _type;

  set type(String value) {
    _type = value;
  }

  int get cycle => _cycle;

  set cycle(int value) {
    _cycle = value;
  }

  int get time => _time;

  set time(int value) {
    _time = value;
  }


}