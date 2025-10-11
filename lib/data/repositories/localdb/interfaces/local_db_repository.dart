import 'package:flutter/material.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 10/08/25
 */

abstract class LocalDbRepository {

  Future<int> insert(Map<String, dynamic> item);
  Future<List<Map<String, dynamic>>> getAll();
  Future<Map<String, dynamic>?> getById(int id);
  Future<List<Map<String, dynamic>>> search(String searchTerm);
  Future<int> update(int id, Map<String, dynamic> item);
  Future<int> hardDelete(int id);
  Future<bool> exists(int id);
  Future<int> count();
  Future<bool> tableHasData();
}