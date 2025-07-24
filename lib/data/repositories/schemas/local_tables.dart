import 'package:flutter/material.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 07/05/25
 */

const String warehousesTable = '''
CREATE TABLE warehouses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        barcode TEXT,
        deleted INTEGER,
        deleted_at TEXT,
        created_at TEXT,
        updated_at TEXT
      )
''';

const String customersTable = '''
CREATE TABLE customers(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        barcode TEXT,
        deleted INTEGER,
        deleted_at TEXT,
        created_at TEXT,
        updated_at TEXT
      )
''';

const String assetsTable = '''
CREATE TABLE assets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        barcode TEXT,
        trademark TEXT,
        model TEXT,
        type TEXT,
        branch INTEGER,
        price REAL,
        deleted INTEGER,
        deleted_at TEXT,
        created_at TEXT,
        updated_at TEXT
      )
''';