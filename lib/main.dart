import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/BottomNavigationView.dart';


void main() => runApp(new ThemeApp());

class ThemeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new BottomNavigationView()
    );
  }
}
