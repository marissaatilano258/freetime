import 'package:sqflite/sqflite.dart';

import 'see_model.dart';

class _SqfliteSeeModelsDBWorker implements SeeModelsDBWorker {

  static const String DB_NAME = 'see_table.db';
  static const String TBL_NAME = 'see_table';
  static const String KEY_ID = '_id';
  static const String KEY_NAME = 'name';
  static const String KEY_DESCRIPTION = 'description';
  static const String KEY_VOTE = 'vote';
  static const String KEY_DATE = 'releaseDate';
  static const String KEY_IMAGE = 'image';

  Database _db;

  _SqfliteSeeModelsDBWorker._();

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
                    "$KEY_DESCRIPTION TEXT,"
                    "$KEY_VOTE TEXT,"
                    "$KEY_DATE TEXT,"
                    "$KEY_IMAGE TEXT"
                    ")"
            );
          }
      );
  }

  @override
  Future<int> create(SeeModel seeModel) async {
    Database db = await database;
    int id = await db.rawInsert(
        "INSERT INTO $TBL_NAME ($KEY_NAME, $KEY_DESCRIPTION, $KEY_VOTE, $KEY_DATE, $KEY_IMAGE) "
            "VALUES (?, ?, ?, ?, ?)",
        [seeModel.name, seeModel.description, seeModel.vote, seeModel.releaseDate, seeModel.image]
    );
    print("Created: $seeModel");
    return id;
  }

  @override
  Future<void> delete(int id) async {
    Database db = await database;
    await db.delete(TBL_NAME, where: "$KEY_ID = ?", whereArgs: [id]);
  }

  @override
  Future<void> update(SeeModel seeModel) async {
    Database db = await database;
    await db.update(TBL_NAME, _seeModelToMap(seeModel),
        where: "$KEY_ID = ?", whereArgs: [seeModel.id]);
    print("Updated: $seeModel");
  }

  @override
  Future<SeeModel> get(int id) async {
    Database db = await database;
    var values = await db.query(TBL_NAME, where: "$KEY_ID = ?", whereArgs: [id]);
    print("GOT SEE MODEL");
    return _seeModelFromMap(values.first);
  }

  @override
  Future<List<SeeModel>> getAll() async {
    Database db = await database;
    var values = await db.query(TBL_NAME);
    return values.isNotEmpty ? values.map((m) => _seeModelFromMap(m)).toList() : [];
  }

  SeeModel _seeModelFromMap(Map map) {
    return SeeModel()
      ..id = map[KEY_ID]
      ..name = map[KEY_NAME]
      ..description = map[KEY_DESCRIPTION]
      ..vote = map[KEY_VOTE]
      ..releaseDate = map[KEY_DATE]
      ..image = map[KEY_IMAGE];
  }

  Map<String, dynamic> _seeModelToMap(SeeModel seeModel) {
    return Map<String, dynamic>()
      ..[KEY_ID] = seeModel.id
      ..[KEY_NAME] = seeModel.name
      ..[KEY_DESCRIPTION] = seeModel.description
      ..[KEY_VOTE] = seeModel.vote
      ..[KEY_DATE] = seeModel.releaseDate
      ..[KEY_IMAGE] = seeModel.image;
  }

}


class SeeModelsDBWorker {

  static final SeeModelsDBWorker db = _SqfliteSeeModelsDBWorker._();

  Future<int> create(SeeModel seeModel){
    return db.create(seeModel);
  }
  update(SeeModel seeModel){
    db.update(seeModel);
  }
  delete(int id){
    db.delete(id);
  }
  Future<SeeModel> get(int id){
    return db.get(id);
  }
  Future<List<SeeModel>> getAll(){
    return db.getAll();
  }
}
