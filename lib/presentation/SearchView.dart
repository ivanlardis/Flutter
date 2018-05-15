import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_ble_lib/flutter_ble_lib.dart';
class SearchView  extends StatefulWidget{

  @override
  SearchState createState() => new SearchState( );

}

class SearchState extends State<SearchView> {

  StreamSubscription _scanDevicesSub;
  StreamSubscription _bluetoothStateSub;

  bool _isScan = false;
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  final List<ScanResult> _scanResults = new List();

  @override
  initState() {
    super.initState();
    _bluetoothStateSub = FlutterBleLib.instance.onStateChange()
        .listen((bluetoothState) =>
        setState(() => this._bluetoothState = bluetoothState));
    FlutterBleLib.instance.state().then((bluetoothState) =>
        setState(() => this._bluetoothState = bluetoothState));
  }




  @override
  Widget build(BuildContext context) {



    return new Scaffold(
      appBar: new AppBar(
        title: new Text(  _bluetoothState.toString()),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(_isScan ? Icons.close : Icons.search),
        onPressed: _isScan ? _onStopScan : _onStartScan,
      ),
//      body: new Column(children: <Widget>[
//      new Text("_bluetoothState "+  _bluetoothState.toString()),
      body: new ListView.builder(
        itemCount: _scanResults.length,
        padding: new EdgeInsets.all(8.0),
        itemExtent: 20.0,
        itemBuilder: (BuildContext context, int index) {
          return new Text('id  '+_scanResults[index].bleDevice.id+" "
          +_scanResults[index].bleDevice.name
          );
        },
      ),
//
//      ],),
    );
  }

  _onStopScan() {
    _scanDevicesSub?.cancel();
    _scanDevicesSub = null;
    FlutterBleLib.instance.stopDeviceScan();
    setState(() {
      _isScan = false;
    });
  }

  _onStartScan() {
    //TODO pass this list as arg to scan only filtered devices
//    List<String> uuids = new List();
//    uuids.add("0000181d-0000-1000-8000-00805f9b34fb");
    _scanDevicesSub = FlutterBleLib.instance
        .startDeviceScan(1, 1, null /*uuids*/)
        .listen(
            (scanResult) => setState(() => _addOrUpdateIfNecessary(scanResult)),
        onDone: _onStopScan);

    setState(() {
      _isScan = true;
    });
  }

  _addOrUpdateIfNecessary(ScanResult scanResultItem) {
    for (var scanResult in _scanResults) {
      if (scanResult.hasTheSameDeviceAs(scanResultItem)) {
        scanResult.update(scanResultItem);
        return;
      }
    }
    _scanResults.add(scanResultItem);
  }


}
