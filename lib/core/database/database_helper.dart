import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:book_clubs/features/profile/models/review_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('book_club.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE reviews(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bookTitle TEXT NOT NULL,
        author TEXT NOT NULL,
        rating INTEGER NOT NULL,
        description TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  // --- MÉTODOS CRUD ---

  // Crear (Create)
  Future<int> insertReview(ReviewModel review) async {
    final db = await instance.database;
    return await db.insert('reviews', review.toMap());
  }

  // Leer todas (Read)
  // Leer todas (Read)
  Future<List<ReviewModel>> getReviews() async {
    final db = await instance.database;
    final maps = await db.query('reviews');
    return maps.map((map) => ReviewModel.fromMap(map)).toList();
  }

  // Actualizar (Update)
  Future<int> updateReview(ReviewModel review) async {
    final db = await instance.database;
    return await db.update(
      'reviews',
      review.toMap(),
      where: 'id = ?',
      whereArgs: [review.id],
    );
  }

  // Eliminar (Delete)
  Future<int> deleteReview(int id) async {
    final db = await instance.database;
    return await db.delete(
      'reviews',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}