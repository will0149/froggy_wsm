import 'package:flutter/material.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 07/05/25
 */

const String warehousesTable = '''
CREATE TABLE warehouses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        barcode TEXT,
        deleted TEXT,
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
        deleted TEXT,
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
        deleted TEXT,
        deleted_at TEXT,
        created_at TEXT,
        updated_at TEXT
      )
''';

const String itemsMasterTable = '''
CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sku TEXT,
        quantity INTEGER,
        qty_difference INTEGER,
        last_compare TEXT,
        created_at TEXT,
        updated_at TEXT
      )
''';

//TODO: validate supported data types
// INTEGER
// SQLite type: INTEGER
// Dart type: int
// Supported values: from -2^63 to 2^63 - 1
// REAL
// SQLite type: REAL
// Dart type: num
// TEXT
// SQLite type: TEXT
// Dart type: String
// BLOB
// SQLite typ: BLOB
// Dart type: Uint8List