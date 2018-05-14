import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/Prefs.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SettingView extends StatefulWidget {
  @override
  createState() => new SettingViewState();
}


class SettingViewState extends State<SettingView> {

  int index = 0;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(title: new Text("Настройки"),),
      body: new Column(
        children: <Widget>[
          new RowSetting(0, "Подготовка ", Prefs.PREPARATION_TIME),
          new RowSetting(0, "Работа ", Prefs.WORK_TIME),
          new RowSetting(0, "Отдых ", Prefs.REST_TIME),
          new RowSetting(0, "Циклы ", Prefs.CYCLE_COUNT),
          new RowSetting(0, "Количество сетов ", Prefs.SET_COUNT),
          new RowSetting(0, "Отдых между сетами ", Prefs.REST_BETWEEN_SETS_COUNT),


        ],
      ),
    );
  }


}


class RowSetting extends StatefulWidget {
  int count = 0;
  int minValue = 0;
  String title = "";
  Prefs type;

  RowSetting(int minValue,
      String title,
      Prefs type) {
    this.count = count;
    this.minValue = minValue;
    this.title = title;

    this.type = type;
  }

  @override
  createState() => new RowSettingState(count, minValue, title, type);
}


abstract class IntCallback {
  void work(int count);
}


class RowSettingState extends State<RowSetting> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;

  int count = 0;
  int minValue = 0;
  String title = "";
  Prefs type;

  @override
  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(type.toString()) ?? 0);
    });
  }

  RowSettingState(int count,
      int minValue,
      String title,
      Prefs type) {
    this.count = count;
    this.minValue = minValue;
    this.title = title;
    this.type = type;
  }


  Future<Null> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt(type.toString()) ?? 0) + 1;

    setState(() {
      _counter = prefs.setInt(type.toString(), counter).then((bool success) {
        return counter;
      });
    });
  }

  Future<Null> _decrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt(type.toString()) ?? 0) - 1;
    if (counter >= minValue) {
      setState(() {
        _counter = prefs.setInt(type.toString(), counter).then((bool success) {
          return counter;
        });
      });
    }
    else
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(
            "Значение не моэет быть меньше $minValue"),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: <Widget>[
        new IconButton(icon: new Icon(Icons.arrow_back,)
            , onPressed: _decrementCounter),

        new FutureBuilder(
            future: _counter,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              switch (snapshot.connectionState) {

                default:
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  else
                    return new Text(
                      '$title  ${snapshot.data}',
                    );
              }
            }),
        new IconButton(icon: new Icon(Icons.arrow_forward,)
            , onPressed: _incrementCounter),

      ],
    );
  }


}
