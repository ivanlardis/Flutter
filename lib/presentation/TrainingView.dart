import 'dart:math';

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
    return new Scaffold(
        appBar: new AppBar(
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
          ],
        ),
        body: new Stack(
          children: <Widget>[
            new Container(
              color: color,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    "ТИП ${getTextByType(trainingModel.type)}",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
                  new Text(
                    "${trainingModel.timeSec}",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 56.0),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        "СЕТЫ ${trainingModel.setCount}",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24.0),
                      ),
                      new Text(
                        "ЦИКЛЫ ${trainingModel.cycleCount}",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24.0),
                      ),
                    ],
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20.0),
            ),
            new Center(
              child: new CustomPaint(
                painter: new MyCustomPainter(
                    //0.0
                   trainingModel.getPercent()
                ),
                size: Size.infinite,
              ),
            )
          ],
        ));
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

class MyCustomPainter extends CustomPainter {
  double _percent = 0.0;

  MyCustomPainter(this._percent);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black26
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    Paint paint1 = new Paint()
      ..color = Colors.blue
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    Path path = new Path()
      ..addArc(
          Rect.fromCircle(
            radius: size.width / 3.0,
            center: new Offset(size.width / 2, size.height / 2),
          ),
          -pi * 2 / 4,
          pi * 2 * _percent / 100);

    canvas.drawCircle(
        new Offset(size.width / 2, size.height / 2), size.width / 3.0, paint);

    canvas.drawPath(path, paint1);
  }

  @override
  bool shouldRepaint(MyCustomPainter other) => other._percent != _percent;
}
