import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/HistoryPresenter.dart';
import 'package:flutter_app/presentation/Models.dart';

class SearchDeviceView extends StatefulWidget {
  @override
  createState() => new SearchDeviceViewState();
}

class SearchDeviceViewState extends State<SearchDeviceView>
    implements IHistoryView {
  List<ModelHistory> models = new List();
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
        itemCount: models.length * 2,
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          print("itemBuilder index $index models ${models[0].workTime}");
          return new HistoryWidget(
              Key("a ${models[index].workTime}"), models[index]);
        },
      ),
    );
  }

  @override
  void show(List<ModelHistory> model) {
    this.setState(() {
      this.models = model;
    });
  }
}

class HistoryWidget extends StatefulWidget {
  ModelHistory _modelTimer;

  HistoryWidget(Key key, this._modelTimer) : super(key: key);

  @override
  createState() => new HistoryState(_modelTimer);
}

class HistoryState extends State<HistoryWidget> {
  ModelHistory _modelTimer;

  HistoryState(this._modelTimer);

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
          new Text(
            "name ${_modelTimer.name}",
            style: TextStyle(fontSize: 24.0),
          ),
          new Text("time ${_modelTimer.time}",
              style: TextStyle(fontSize: 24.0)),
        ]),
        new TableRow(children: <Widget>[
          new Text("restTime ${_modelTimer.restTime}"),
          new Text("workTime ${_modelTimer.workTime}"),
        ]),
        new TableRow(children: <Widget>[
          new Text("cycleCount ${_modelTimer.setCount}"),
          new Text("cycleCount ${_modelTimer.cycleCount}"),
        ]),
      ],
    );
  }
}
