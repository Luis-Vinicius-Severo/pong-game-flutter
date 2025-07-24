import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'pong_game.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE scores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        score INTEGER
      )
    ''');
  }

  Future<void> insertScore(String name, int score) async {
    final db = await database;

    // Verifica se já existem 10 pontuações
    final List<Map<String, dynamic>> topScores = await getTopScores();

    if (topScores.length < 10 || score > topScores.last['score']) {
      // Se já tiver 10, remove o pior
      if (topScores.length == 10) {
        await db.delete(
          'scores',
          where: 'id = ?',
          whereArgs: [topScores.last['id']],
        );
      }

      await db.insert('scores', {
        'name': name,
        'score': score,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Map<String, dynamic>>> getTopScores() async {
    final db = await database;
    return await db.query('scores', orderBy: 'score DESC', limit: 10);
  }
}
