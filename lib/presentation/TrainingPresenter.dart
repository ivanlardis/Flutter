import 'dart:async';

import 'package:flutter_app/domain/BussinesFormul.dart';
import 'package:flutter_app/presentation/Data.dart';
import 'package:flutter_app/presentation/Models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class ITrainingView {
  void show(ModelTimer model);
}

class TrainingPresenter {


  ITrainingView iTrainingView;

  TrainingPresenter(this.iTrainingView);

  StreamSubscription subscription;

  void startTrain() {


    SharedPreferences.getInstance().asStream()
        .listen((shar) => calculate(shar));
  }

  void calculate(SharedPreferences prefs) {
    stopTrain();
    List<ModelTimer> list = getListTrain(prefs);

    subscription = new Observable<ModelTimer>.fromIterable(list)
        .interval(new Duration(seconds: 1))
        .listen((modelTimer) =>
        iTrainingView.show(modelTimer)); // prints 1 sec, 2 sec, 3 sec
  }

  void stopTrain() {
    if (subscription != null) {
      subscription.cancel();
      subscription = null;
    }

    var a = new ModelTimer();

    iTrainingView.show(a);
  }


}

