import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../model/artical_model_db.dart';

class ArticleDataBase {
  static final ArticleDataBase instance = ArticleDataBase._init();
  static Database _database;
  ArticleDataBase._init();
  List<Article> savedArticle;
  int index;

  Future<Database> get dataBase async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, 'News.db');
    return await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      final idType = ' INTEGER PRIMARY KEY AUTOINCREMENT ';
      final textType = 'TEXT NOT NULL';
      final boolType = 'BOOLEAN NOT NULL';
      final integerType = 'INTEGER NOT NULL';
      await db.execute('''
CREATE TABLE $tableArticle (
  ${ArticleFields.id} $idType,
  ${ArticleFields.url} $integerType,
  ${ArticleFields.dark} $boolType,
  ${ArticleFields.image} $integerType,
  ${ArticleFields.title} $textType,
  ${ArticleFields.time} $textType
)
''');
      print('==============Created DataBase =================');
    });
  }

  Future<Article> create(Article Article) async {
    final db = await instance.dataBase;
    final id = await db.insert(tableArticle, Article.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('==============Created Successfuly =================');

    return Article.copy(id: id);
  }

  Future<Article> readArticle(int id) async {
    final db = await instance.dataBase;
    final map = await db.query(tableArticle,
        columns: ArticleFields.values,
        where: '${ArticleFields.id} = ?',
        whereArgs: [id]);
    if (map.isNotEmpty) {
      return Article.fromJson(map.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Article>> readAllNotes() async {
    final db = await instance.dataBase;

    final orderBy = '${ArticleFields.time} ASC';
    final result = await db.query(tableArticle, orderBy: orderBy);

    return result.map((json) => Article.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.dataBase;

    return await db.delete(
      tableArticle,
      where: '${ArticleFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.dataBase;
    db.close();
  }
}
