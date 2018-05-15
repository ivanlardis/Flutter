import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/SearchDeviceView.dart';
import 'package:flutter_app/presentation/SearchView.dart';
import 'package:flutter_app/presentation/SettingView.dart';
import 'package:flutter_app/presentation/TrainingView.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';


class BottomNavigationView extends StatefulWidget {
  @override
  createState() => new BottomNavigationViewState();
}

class BottomNavigationViewState extends State<BottomNavigationView> {

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: index != 0,
            child: new TickerMode(
              enabled: index == 0,
              child: new MaterialApp(home: new TrainingView()),
            ),
          ),
          new Offstage(
            offstage: index != 1,
            child: new TickerMode(
              enabled: index == 1,
              child: new MaterialApp(home: new SearchDeviceView()),
            ),
          ),
          new Offstage(
            offstage: index != 2,
            child: new TickerMode(
              enabled: index == 2,
              child: new MaterialApp(home: new SettingView()),
            ),
          ),
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: index,
        onTap: (int index) {
          setState(() {
            this.index = index;
          });
        },
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: new Icon(Icons.access_time),
            title: new Text("Тренировка"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: new Text("Поиск"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            title: new Text("Настройки"),
          ),
        ],
      ),
    );
  }


  void _openSearchView() {
    FlutterBleLib.instance.createClient(null).then(
            (data) =>


            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) {
                  return new SearchView();
                },
              ),
            )

    );
  }
}
