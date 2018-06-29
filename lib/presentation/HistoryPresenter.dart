
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:flutter_app/presentation/Data.dart';
import 'package:flutter_app/presentation/Models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class IHistoryView {
  void show(List<ModelHistory> model);
}

class HistoryPresenter {
  IHistoryView iHistoryView;

  HistoryPresenter(this.iHistoryView);



//
//  @ColumnInfo(name = "name") var name: String,
//  @PrimaryKey(autoGenerate = true) @ColumnInfo(name = "time") var time: Long,
//  @ColumnInfo(name = "workTime") var workTime: Int,
//  @ColumnInfo(name = "restTime") var restTime: Int,
//  @ColumnInfo(name = "cycleCount") var cycleCount: Int,
//  @ColumnInfo(name = "setCount") var setCount: Int)




  void startTrain() async {

    List<ModelHistory> history=await DB.getData();



    if (iHistoryView != null) {

      iHistoryView.show(history);
    }


    List<ModelHistory> network=await Repository.getData();

    if (iHistoryView != null) {

      iHistoryView.show(network);
    }
  }

  void save() {}
}


