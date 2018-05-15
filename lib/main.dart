import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/BottomNavigationView.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';


void main() {
  FlutterBleLib.instance.createClient( null);

  runApp(new ThemeApp());}

class ThemeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new BottomNavigationView()
    );
  }
}
