import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/HistoryPresenter.dart';
import 'package:flutter_app/presentation/Models.dart';

class SearchDeviceView extends StatefulWidget {
  @override
  createState() => new SearchDeviceViewState();
}

class SearchDeviceViewState extends State<SearchDeviceView> implements IHistoryView {
  List<ModelHistory> models=new List();
  HistoryPresenter presenter;
  @override
  void initState() {
    super.initState();
    presenter = new HistoryPresenter(this);
    presenter.startTrain();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("История тренировок"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.update),
            onPressed: () {
              presenter.startTrain();
            },
          ),

        ],
      ),
      body: new ListView.builder(

        itemCount: models.length,
        itemBuilder: (BuildContext context, int index) {
          print("itemBuilder index $index models ${models[0].workTime}");
          return new HistoryWidget(models[index]);
        },
      ),
    );
  }

  @override
  void show(List<ModelHistory> model) {
    print("show ${model[0].workTime}");
    this.setState(() {

     this.models=model;

   });

  }


}

class HistoryWidget extends StatefulWidget {

  ModelHistory modelTimer;

  HistoryWidget(this.modelTimer);

  @override
  createState() => new HistoryState(modelTimer);
}

class HistoryState extends State<HistoryWidget> {

  ModelHistory modelTimer;

  HistoryState(this.modelTimer);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("HistoryState initState");
  }
  
  @override
  Widget build(BuildContext context) {
    return new Table(

      children: <TableRow>[
        new TableRow(children: <Widget>[
          new Text("userName ${modelTimer.userName}" ,style: TextStyle(fontSize: 24.0),),
          new Text("time ${modelTimer.time}",style: TextStyle(fontSize: 24.0)),

        ]), new TableRow(children: <Widget>[
          new Text("restTime ${modelTimer.restTime}"),
          new Text("workTime ${modelTimer.workTime}"),

        ]), new TableRow(children: <Widget>[
          new Text("cycleCount ${modelTimer.setCount}"),
          new Text("cycleCount ${modelTimer.cycleCount}"),

        ]),
      ],
    );
  }
}
