import 'package:sqflite/sqflite.dart';

import 'surprise_model.dart';

class _SqfliteSurpriseModelsDBWorker implements SurpriseModelsDBWorker {

  static const String DB_NAME = 'eat_table.db';
  static const String TBL_NAME = 'eat_table';
  static const String KEY_ID = '_id';
  static const String KEY_SURPRISE = 'surprise';
  static const String KEY_TYPE = 'type';
  static const String KEY_PARTICIPANTS = 'participants';

  Database _db;

  _SqfliteSurpriseModelsDBWorker._();

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
                    "$KEY_SURPRISE TEXT,"
                    "$KEY_TYPE TEXT,"
                    "$KEY_PARTICIPANTS TEXT"
                    ")"
            );
          }
      );
  }

  @override
  Future<int> create(SurpriseModel surpriseModel) async {
    Database db = await database;
    int id = await db.rawInsert(
        "INSERT INTO $TBL_NAME ($KEY_SURPRISE, $KEY_TYPE, $KEY_PARTICIPANTS) "
            "VALUES (?, ?, ?)",
        [surpriseModel.surprise, surpriseModel.type, surpriseModel.participants]
    );
    print("Created: $surpriseModel");
    return id;
  }

  @override
  Future<void> delete(int id) async {
    Database db = await database;
    await db.delete(TBL_NAME, where: "$KEY_ID = ?", whereArgs: [id]);
  }

  @override
  Future<void> update(SurpriseModel surpriseModel) async {
    Database db = await database;
    await db.update(TBL_NAME, _surpriseModelToMap(surpriseModel),
        where: "$KEY_ID = ?", whereArgs: [surpriseModel.id]);
    print("Updated: $surpriseModel");
  }

  @override
  Future<SurpriseModel> get(int id) async {
    Database db = await database;
    var values = await db.query(TBL_NAME, where: "$KEY_ID = ?", whereArgs: [id]);
    print("GOT SURPRISE MODEL");
    return _surpriseModelFromMap(values.first);
  }

  @override
  Future<List<SurpriseModel>> getAll() async {
    Database db = await database;
    var values = await db.query(TBL_NAME);
    return values.isNotEmpty ? values.map((m) => _surpriseModelFromMap(m)).toList() : [];
  }

  SurpriseModel _surpriseModelFromMap(Map map) {
    return SurpriseModel()
      ..id = map[KEY_ID]
      ..surprise = map[KEY_SURPRISE]
      ..type = map[KEY_TYPE]
      ..participants = map[KEY_PARTICIPANTS];
  }

  Map<String, dynamic> _surpriseModelToMap(SurpriseModel surpriseModel) {
    return Map<String, dynamic>()
      ..[KEY_ID] = surpriseModel.id
      ..[KEY_SURPRISE] = surpriseModel.surprise
      ..[KEY_TYPE] = surpriseModel.type
      ..[KEY_PARTICIPANTS] = surpriseModel.participants;
  }

}


class SurpriseModelsDBWorker {

  static final SurpriseModelsDBWorker db = _SqfliteSurpriseModelsDBWorker._();

  Future<int> create(SurpriseModel surpriseModel){
    return db.create(surpriseModel);
  }
  update(SurpriseModel surpriseModel){
    db.update(surpriseModel);
  }
  delete(int id){
    db.delete(id);
  }
  Future<SurpriseModel> get(int id){
    return db.get(id);
  }
  Future<List<SurpriseModel>> getAll(){
    return db.getAll();
  }
}
