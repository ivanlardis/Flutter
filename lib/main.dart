import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/BottomNavigationView.dart';
import 'package:flutter_app/presentation/Data.dart';
import 'package:flutter_app/presentation/HistoryPresenter.dart';


void main() {
  DB.init();


  runApp(new ThemeApp());
}

class ThemeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new BottomNavigationView()
    );
  }
}
