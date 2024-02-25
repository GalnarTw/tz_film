// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider db = DBProvider();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, 'DB.db');
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  void onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS DB (
      id INT NOT NULL,
      name TEXT,
      year INT NOT NULL,
      description TEXT,
      poster TEXT,
      rating INT NOT NULL,
      islike INT NOT NULL
      )
      ''');
  }
}
