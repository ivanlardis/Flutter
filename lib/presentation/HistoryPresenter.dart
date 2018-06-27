import 'dart:async';
import 'dart:math';

import 'package:flutter_app/domain/BussinesFormul.dart';
import 'package:flutter_app/presentation/Models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class IHistoryView {
  void show(List<ModelHistory> model);
}

class HistoryPresenter {


  IHistoryView iHistoryView;

  HistoryPresenter(this.iHistoryView);


  void startTrain() {
print("awdwad");
    if (iHistoryView != null) {
      print("iHistoryView != null");
      List<ModelHistory> models=new List();
      ModelHistory history=new ModelHistory();

      history.workTime=new Random().nextInt(12);
      history.restTime=7;

      history.time=2;
      history.userName="ivan";
      history.cycleCount=3;

      models.add(history);



      iHistoryView.show(models);
    }






  }




}

