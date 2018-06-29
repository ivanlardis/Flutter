import 'package:flutter_app/presentation/Models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DB {
  static Database database;

  static void save(ModelHistory model) async {
    if (database != null) {
      await database.transaction((txn) async {
        int id1 = await txn.rawInsert(
            'INSERT INTO Test(time, workTime,  setCount,  restTime,  cycleCount, name) '
            'VALUES'
            '( ${model.time},'
            '${model.workTime},'
            '${model.setCount},'
            '${model.restTime},'
            '${model.cycleCount},'
            '"${model.name}" )');

        print("save: $id1");
      });
    }
  }

  static void get() async {
    if (database != null) {
      List<Map> list = await database.rawQuery('SELECT * FROM Test');
      print(list);
    }
  }

  static void init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "demo.db");

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute("CREATE TABLE Test"
          " (time INTEGER PRIMARY KEY, "
          "workTime INTEGER, "
          "setCount INTEGER, "
          "restTime INTEGER, "
          "cycleCount INTEGER, "
          " name TEXT)");
    });
  }
}

class NW {
  static Future<http.Response> fetchPost() {
    return http.get('https://timerble-8665b.firebaseio.com/messages.json');
  }

  static Future<List<ModelHistory>> getData() async {
    http.Response response = await fetchPost();

    Map map = json.decode(response.body);

    List<ModelHistory> models = new List();

    void iterateMapEntry(key, value) {
      ModelHistory history = ModelHistory.fromJson(value);
      print('$key:$value'); //string interpolation in action
      models.add(history);
    }

    map.forEach(iterateMapEntry);

    var completer = new Completer<List<ModelHistory>>();
    completer.complete(models);

    return completer.future;
  }
}
