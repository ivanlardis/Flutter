import 'package:flutter/material.dart';
import 'package:flutter_app/domain/BussinesFormul.dart';
import 'package:flutter_app/presentation/Models.dart';
import 'package:flutter_app/presentation/TrainingPresenter.dart';


class TrainingView extends StatefulWidget {
  @override
  createState() => new TrainingViewState();
}


class TrainingViewState extends State<TrainingView> implements ITrainingView {
  TrainingPresenter presenter;

  ModelTimer trainingModel = new ModelTimer();
  int index = 0;
  Color color = Colors.white;


  @override
  void initState() {
    super.initState();
    presenter = new TrainingPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: new AppBar(
      title: new Text("ТАЙМЕР"),

      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.trending_up),
          onPressed: () {
            presenter.startTrain();
          },
        ),
        new IconButton(
          icon: new Icon(Icons.trending_down),
          onPressed: () {
            presenter.stopTrain();
          },
        ),
      ],),
        body: new Container(
          color: color,
          child: new Column(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text("ТИП ${getTextByType(trainingModel.type)}",
                style: new TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 24.0),),
              new Text("${trainingModel.timeSec}",
                style: new TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 56.0),

              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("СЕТЫ ${trainingModel.setCount}",
                    style: new TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 24.0),),
                  new Text("ЦИКЛЫ ${trainingModel.cycleCount}",
                    style: new TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 24.0),),

                ],),
            ],),
          padding: const EdgeInsets.all(20.0),
        )


    );
  }

  @override
  void show(ModelTimer model) {

    setState(() {
      trainingModel = model;
      color = getColorByType(trainingModel.type);
    });
  }

  String getTextByType(TYPE type) {
    switch (type) {
      case TYPE.PREPARATION_TIME:
        return "ПОДГОТОВКА";
        break;
      case TYPE.REST_BETWEEN_SETS_COUNT:
        return "ОТДЫХ МЕЖДУ СЕТАМИ";
        break;
      case TYPE.WORK_TIME:
        return "РАБОТА";
        break;
      case TYPE.REST_TIME:
        return "ОТДЫХ";
        break;
      case TYPE.EMPTY:
        return "Начать тренировку?";
        break;
    }
    return "";
  }

  Color getColorByType(TYPE type) {
    switch (type) {
      case TYPE.PREPARATION_TIME:
        return Colors.green;
        break;
      case TYPE.REST_BETWEEN_SETS_COUNT:
        return Colors.grey;
        break;
      case TYPE.WORK_TIME:
        return Colors.red;
        break;
      case TYPE.REST_TIME:
        return Colors.blue;
        break;
      case TYPE.EMPTY:
        return Colors.white;
        break;
    }
    return Colors.white;
  }

}


