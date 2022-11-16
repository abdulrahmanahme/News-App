import 'package:news/model/artical_model_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ArticalDataBase {

  static final ArticalDataBase instance = ArticalDataBase._init();
  static Database _database;
  ArticalDataBase._init();
  List<Artical> savedArtical;
 int index;

  Future<Database> get dataBase async {
    if (_database != null) return _database;
    _database = await _initDB(); 
    return _database;
  }

  Future<Database> _initDB() async {
    final dbpath = await getDatabasesPath();
    final path =  join(dbpath, 'News.db');
    return await openDatabase(path,
        version: 2, onCreate:(Database db, int version)async{
    final idType = ' INTEGER PRIMARY KEY AUTOINCREMENT ';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    await db.execute('''
CREATE TABLE $tableArtical (
  ${ArticalFields.id} $idType,
  ${ArticalFields.url} $integerType,
  ${ArticalFields.dark} $boolType,
  ${ArticalFields.image} $integerType,
  ${ArticalFields.title} $textType,
  ${ArticalFields.time} $textType
)
'''); 
    print('==============Created DataBase =================');

});
  


  }


  Future<Artical> create(Artical artical) async {
    final db = await instance.dataBase;
    final id = await db.insert(tableArtical, artical.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
        // if(artical.title ==savedArtical[index].title){
        

        // }
    print('==============Created Successfuly =================');

    return artical.copy(id: id);
  }

  Future<Artical> readArtical(int id) async {
    final db = await instance.dataBase;
    final map = await db.query(tableArtical,
        columns: ArticalFields.values,
        where: '${ArticalFields.id} = ?',
        whereArgs: [id]);
    if (map.isNotEmpty) {
      return Artical.fromJson(map.first);
    } else {
      throw Exception('ID $id not found');
    }
  }
Future<List<Artical>> readAllNotes() async {
    final db = await instance.dataBase;

    final orderBy = '${ArticalFields.time} ASC';
    final result = await db.query(tableArtical, orderBy: orderBy);

    return result.map((json) =>Artical.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.dataBase;

    return await db.delete(
      tableArtical,
      where: '${ArticalFields.id} = ?',
      whereArgs: [id],
    );
  }


  

  Future close() async {
    final db = await instance.dataBase;
    db.close();
  }
}
