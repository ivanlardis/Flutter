import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/SearchView.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Стартовый экран '),
        ),
        body: new Center(

            child: new Column(
              children: <Widget>[
                new RandomWords(),]
              ,)

        ),

      ),
    );
  }
}


class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    return new RaisedButton(onPressed: _openSearchView
      ,
      child: new Text(" _openSearchView "),
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
