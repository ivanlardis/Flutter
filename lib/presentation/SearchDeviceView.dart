import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/SearchView.dart';




class SearchDeviceView extends StatefulWidget {
  @override
  createState() => new SearchDeviceViewState();
}


class SearchDeviceViewState extends State<SearchDeviceView> {

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return new SearchView();
  }


 
}