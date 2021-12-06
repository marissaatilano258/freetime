import 'package:sqflite/sqflite.dart';

import 'eat_model.dart';

class _SqfliteEatModelsDBWorker implements EatModelsDBWorker {

  static const String DB_NAME = 'eats_table.db';
  static const String TBL_NAME = 'eats_table';
  static const String KEY_ID = '_id';
  static const String KEY_NAME = 'name';
  static const String KEY_PHONE = 'phone';
  static const String KEY_ADDRESS = 'address';
  static const String KEY_WEBSITE = 'website';

  Database _db;

  _SqfliteEatModelsDBWorker._();

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
                    "$KEY_PHONE TEXT,"
                    "$KEY_ADDRESS TEXT,"
                    "$KEY_WEBSITE TEXT"
                    ")"
            );
          }
      );
  }

  @override
  Future<int> create(EatModel eatModel) async {
    Database db = await database;
    int id = await db.rawInsert(
        "INSERT INTO $TBL_NAME ($KEY_NAME, $KEY_PHONE, $KEY_ADDRESS, $KEY_WEBSITE) "
            "VALUES (?, ?, ?, ?)",
        [eatModel.name, eatModel.phone, eatModel.address, eatModel.website]
    );
    print("Created: $eatModel");
    return id;
  }

  @override
  Future<void> delete(int id) async {
    Database db = await database;
    await db.delete(TBL_NAME, where: "$KEY_ID = ?", whereArgs: [id]);
  }

  @override
  Future<void> update(EatModel eatModel) async {
    Database db = await database;
    await db.update(TBL_NAME, _eatModelToMap(eatModel),
        where: "$KEY_ID = ?", whereArgs: [eatModel.id]);
    print("Updated: $eatModel");
  }

  @override
  Future<EatModel> get(int id) async {
    Database db = await database;
    var values = await db.query(TBL_NAME, where: "$KEY_ID = ?", whereArgs: [id]);
    print("GOT EAT MODEL");
    return _eatModelFromMap(values.first);
  }

  @override
  Future<List<EatModel>> getAll() async {
    Database db = await database;
    var values = await db.query(TBL_NAME);
    return values.isNotEmpty ? values.map((m) => _eatModelFromMap(m)).toList() : [];
  }

  EatModel _eatModelFromMap(Map map) {
    return EatModel()
      ..id = map[KEY_ID]
      ..name = map[KEY_NAME]
      ..phone = map[KEY_PHONE]
      ..address = map[KEY_ADDRESS]
      ..website = map[KEY_WEBSITE];
  }

  Map<String, dynamic> _eatModelToMap(EatModel eatModel) {
    return Map<String, dynamic>()
      ..[KEY_ID] = eatModel.id
      ..[KEY_NAME] = eatModel.name
      ..[KEY_PHONE] = eatModel.phone
      ..[KEY_ADDRESS] = eatModel.address
      ..[KEY_WEBSITE] = eatModel.website;
  }

}


class EatModelsDBWorker {

  static final EatModelsDBWorker db = _SqfliteEatModelsDBWorker._();

  Future<int> create(EatModel eatModel){
    return db.create(eatModel);
  }
  update(EatModel eatModel){
    db.update(eatModel);
  }
  delete(int id){
    db.delete(id);
  }
  Future<EatModel> get(int id){
    return db.get(id);
  }
  Future<List<EatModel>> getAll(){
    return db.getAll();
  }
}
