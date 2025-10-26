import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../../configs/database_helper.dart';
import '../interfaces/local_db_repository.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/15/25
 */

class RecountItemsRepository implements LocalDbRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final String _tableName = 'recount_items';

  @override
  Future<int> insert(Map<String, dynamic> item) async {
    final db = await _dbHelper.database;
    return await db.insert(_tableName, item, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<bool> exists(int id) {
    // TODO: implement exists
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await _dbHelper.database;

    return await db.rawQuery('''
    SELECT 
      recount_items.reference,
      recount_items.quantity AS countQty,
      items.quantity AS serviceQty,
      items.name
    FROM recount_items
    LEFT JOIN items
    ON recount_items.reference = items.reference
    ''');
  }

  @override
  Future<Map<String, dynamic>?> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<int> hardDelete(int id) {
    // TODO: implement hardDelete
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> search(String searchTerm) {
    // TODO: implement search
    throw UnimplementedError();
  }

  @override
  Future<bool> tableHasData() {
    // TODO: implement tableHasData
    throw UnimplementedError();
  }

  @override
  Future<int> update(int id, Map<String, dynamic> item) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<void> deleteTable() async {
    final db = await _dbHelper.database;
    await db.delete(_tableName);
  }
}