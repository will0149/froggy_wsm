import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../configs/database_helper.dart';
import 'interfaces/local_db_repository.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 10/08/25
 */

class AlegraItemsRepository implements LocalDbRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final String _tableName = 'items';

  @override
  Future<int> insert(Map<String, dynamic> item) async {
    final db = await _dbHelper.database;
    return await db.insert(_tableName, item, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await _dbHelper.database;
    return await db.query(_tableName, orderBy: "name DESC");
  }

  @override
  Future<Map<String, dynamic>?> getById(int id) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      _tableName,
      where: 'id = ? AND deleted = ?',
      whereArgs: [id, 0],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getByBarcode(String barcode) async {
    final db = await _dbHelper.database;
    return await db.query(
      _tableName,
      where: 'barcode = ? AND deleted = ?',
      whereArgs: [barcode, 0],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> search(String searchTerm) async {
    final db = await _dbHelper.database;
    return await db.query(
      _tableName,
      where: '(name LIKE ? OR description LIKE ? OR barcode LIKE ?) AND deleted = ?',
      whereArgs: ['%$searchTerm%', '%$searchTerm%', '%$searchTerm%', 0],
    );
  }

  @override
  Future<int> update(int id, Map<String, dynamic> item) async {
    final db = await _dbHelper.database;
    item['updated_at'] = DateTime.now().toIso8601String();
    return await db.update(
      _tableName,
      item,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> softDelete(int id) async {
    final db = await _dbHelper.database;
    return await db.update(
      _tableName,
      {
        'deleted': 1,
        'deleted_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> hardDelete(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> restore(int id) async {
    final db = await _dbHelper.database;
    return await db.update(
      _tableName,
      {
        'deleted': 0,
        'deleted_at': null,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getDeleted() async {
    final db = await _dbHelper.database;
    return await db.query(_tableName, where: 'deleted = ?', whereArgs: [1]);
  }

  @override
  Future<bool> exists(int id) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  @override
  Future<int> count() async {
    final db = await _dbHelper.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM $_tableName WHERE deleted = 0');
    return result.first['count'] as int;
  }

  @override
  Future<bool> tableHasData() async {
    final db = await _dbHelper.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM $_tableName');
    final count = Sqflite.firstIntValue(result); // returns int?
    return (count ?? 0) > 0;
  }
}