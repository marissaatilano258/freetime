import 'package:sqflite/sqflite.dart';

import 'do_model.dart';

class _SqfliteDoModelsDBWorker implements DoModelsDBWorker {

  static const String DB_NAME = 'do_table.db';
  static const String TBL_NAME = 'do_table';
  static const String KEY_ID = '_id';
  static const String KEY_NAME = 'name';
  static const String KEY_LOCATION = 'location';
  static const String KEY_DATE = 'date';
  static const String KEY_TIME = 'time';
  static const String KEY_WEBSITE = 'website';

  Database _db;

  _SqfliteDoModelsDBWorker._();

  Future<Database> get database async =>
      _db ??= await _init();

  Future<Database> _init() async {
    return
      await openDatabase(DB_NAME,
          version: 1,
          onOpen: (db) {},
          onCreate: (Database db, int version) async {
            await db.execute(
                "CREATE TABLE IF NOT EXISTS $TBL_NAME ("
                    "$KEY_ID INTEGER PRIMARY KEY,"
                    "$KEY_NAME TEXT,"
                    "$KEY_LOCATION TEXT,"
                    "$KEY_DATE TEXT,"
                    "$KEY_TIME TEXT,"
                    "$KEY_WEBSITE TEXT"
                    ")"
            );
          }
      );
  }

  @override
  Future<int> create(DoModel doModel) async {
    Database db = await database;
    int id = await db.rawInsert(
        "INSERT INTO $TBL_NAME ($KEY_NAME, $KEY_LOCATION, $KEY_DATE, $KEY_TIME, $KEY_WEBSITE) "
            "VALUES (?, ?, ?, ?, ?)",
        [doModel.name, doModel.location, doModel.date, doModel.time, doModel.website]
    );
    print("Created: $doModel");
    return id;
  }

  @override
  Future<void> delete(int id) async {
    Database db = await database;
    await db.delete(TBL_NAME, where: "$KEY_ID = ?", whereArgs: [id]);
  }

  @override
  Future<void> update(DoModel doModel) async {
    Database db = await database;
    await db.update(TBL_NAME, _doModelToMap(doModel),
        where: "$KEY_ID = ?", whereArgs: [doModel.id]);
    print("Updated: $doModel");
  }

  @override
  Future<DoModel> get(int id) async {
    Database db = await database;
    var values = await db.query(TBL_NAME, where: "$KEY_ID = ?", whereArgs: [id]);
    print("GOT DO MODEL");
    return _doModelFromMap(values.first);
  }

  @override
  Future<List<DoModel>> getAll() async {
    Database db = await database;
    var values = await db.query(TBL_NAME);
    return values.isNotEmpty ? values.map((m) => _doModelFromMap(m)).toList() : [];
  }

  DoModel _doModelFromMap(Map map) {
    return DoModel()
      ..id = map[KEY_ID]
      ..name = map[KEY_NAME]
      ..location = map[KEY_LOCATION]
      ..date = map[KEY_DATE]
      ..time = map[KEY_TIME]
      ..website = map[KEY_WEBSITE];
  }

  Map<String, dynamic> _doModelToMap(DoModel doModel) {
    return Map<String, dynamic>()
      ..[KEY_ID] = doModel.id
      ..[KEY_NAME] = doModel.name
      ..[KEY_LOCATION] = doModel.location
      ..[KEY_DATE] = doModel.date
      ..[KEY_TIME] = doModel.time
      ..[KEY_WEBSITE] = doModel.website;
  }

}


class DoModelsDBWorker {

  static final DoModelsDBWorker db = _SqfliteDoModelsDBWorker._();

  Future<int> create(DoModel doModel){
    return db.create(doModel);
  }
  update(DoModel doModel){
    db.update(doModel);
  }
  delete(int id){
    db.delete(id);
  }
  Future<DoModel> get(int id){
    return db.get(id);
  }
  Future<List<DoModel>> getAll(){
    return db.getAll();
  }
}
