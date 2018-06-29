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


      });
    }
  }

  static Future<List<ModelHistory>> getData() async {
    print("getData");
    var completer = new Completer<List<ModelHistory>>();




    if (database != null) {
      List<Map> list = await database.rawQuery('SELECT * FROM Test');
      print("getData ${list}");
      List<ModelHistory> listHistory=mapper(list);

      completer.complete(listHistory);
      return  completer.future;

    }
    else {
      completer.complete(new List());
      return  completer.future;
    }

  }


  static List<ModelHistory> mapper(List map) {
    List<ModelHistory> models = new List();

    void iterateMapEntry(  value) {
      ModelHistory history = ModelHistory.fromJson(value);
      print("getData history.workTime  ${history.workTime}");
      models.add(history);
    }

    map.forEach(iterateMapEntry);
    return models;
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

class Repository {

  static Future<List<ModelHistory>> getData() async {

    List<ModelHistory> dbData= await  DB.getData();
    print(dbData.length);
    void iterateMapEntry(value) {
    NW.save(value);
    }
    dbData.forEach(iterateMapEntry);

 return NW.getData();

  }

}

class NW {

  static List<ModelHistory> mapper(Map map) {
    List<ModelHistory> models = new List();

    void iterateMapEntry(key, value) {
      ModelHistory history = ModelHistory.fromJson(value);

      models.add(history);
    }

    map.forEach(iterateMapEntry);
    return models;
  }


  static Future<List<ModelHistory>> getData() async {




    http.Response response = await http.get('https://timerble-8665b.firebaseio.com/messages.json');
    Map map = json.decode(response.body);
    List<ModelHistory> models = mapper(map);

    var completer = new Completer<List<ModelHistory>>();
    completer.complete(models);

    return completer.future;
  }


  static void save(ModelHistory model) async {

    http.post('https://timerble-8665b.firebaseio.com/messages.json',
    body: json.encode(model.toJson())
    );
  }
}
