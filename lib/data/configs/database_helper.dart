import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../repositories/schemas/local_tables.dart';
/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 03/23/25
 */

class DatabaseHelper {
  // Singleton pattern to ensure a single instance of the database
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
    // Get the path to the database file
    String path = join(await getDatabasesPath(), 'app_database.db');
    // Open the database (or create it if it doesn't exist)
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create tables here
    await db.execute(warehousesTable);
    await db.execute(customersTable);
    await db.execute(assetsTable);
  }

  // Example CRUD operations
  Future<void> insertUser(String schema, Map<String, dynamic> data) async {
    final db = await database;
    await db.insert(schema, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<void> updateUser(String schema, Map<String, dynamic> data) async {
    final db = await database;
    await db.update(
      schema,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  Future<void> deleteUser(String schema, int id) async {
    final db = await database;
    await db.delete(
      schema,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> tableHasData(Database db, String tableName) async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM $tableName');

    final count = Sqflite.firstIntValue(result); // returns int?
    return (count ?? 0) > 0;
  }

  Future<void> clearDatabase() async {
    final db = await database;
    
    // Get all table names
    final List<Map<String, dynamic>> tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'"
    );
    
    // Delete all records from each table
    for (final table in tables) {
      final tableName = table['name'] as String;
      await db.delete(tableName);
    }
  }
}