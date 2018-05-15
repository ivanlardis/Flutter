import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/TrainingPresenter.dart';


class TrainingView extends StatefulWidget {
  @override
  createState() => new TrainingViewState();
}


class TrainingViewState extends State<TrainingView> implements ITrainingView {
  TrainingPresenter presenter;

  TrainingModel trainingModel = new TrainingModel();
  int index = 0;


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
            presenter.stopTrain();
          },
        ),
        new IconButton(
          icon: new Icon(Icons.trending_down),
          onPressed: () {
            presenter.startTrain();
          },
        ),
      ],),
        body: new Container(
          child: new Column(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text("ТИП ${trainingModel.type}",
                style: new TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 24.0),),
              new Text("${trainingModel.time}",
                style: new TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 56.0),

              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("СЕТЫ ${trainingModel.set}",
                    style: new TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 24.0),),
                  new Text("ЦИКЛЫ ${trainingModel.cycle}",
                    style: new TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 24.0),),

                ],),
            ],),
          margin: const EdgeInsets.all(20.0),
        )


    );
  }

  @override
  void show(TrainingModel model) {
    print("show ${model.set}");
    setState(() {
      trainingModel = model;
    });
  }

}


