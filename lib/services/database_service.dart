import 'package:report/models/report_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'reports.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE reports('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'title TEXT, '
              'name TEXT, '
              'intro TEXT, '
              'objectives TEXT, '
              'method TEXT, '
              'results TEXT, '
              'conclusion TEXT, '
              'dateCreated TEXT, '
              'pdfPath TEXT)',
        );
      },
    );
  }

  Future<void> insertReport(Report report) async {
    final db = await database;
    await db.insert('reports', report.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Report>> getRecentReports() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'reports',
      orderBy: 'dateCreated DESC',
      limit: 2,
    );

    return List.generate(maps.length, (i) {
      return Report.fromMap(maps[i]);
    });
  }

  // دالة جديدة لجلب جميع التقارير
  Future<List<Report>> getAllReports() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'reports',
      orderBy: 'dateCreated DESC', // ترتيب التقارير من الأحدث للأقدم
    );

    return List.generate(maps.length, (i) {
      return Report.fromMap(maps[i]);
    });
  }

  // دالة حذف تقرير
  Future<void> deleteReport(int id) async {
    final db = await database;
    await db.delete(
      'reports',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // دالة حذف جميع التقارير
  Future<void> deleteAllReports() async {
    final db = await database;
    await db.delete('reports');
  }
}