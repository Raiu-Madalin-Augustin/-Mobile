import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'my_home_page.dart';
class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'groceries.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE groceries(
          id INTEGER PRIMARY KEY,
          name TEXT,
          genre TEXT,
          numberOfSeasonsWatched INTEGER,
          numberOfEpisodesWatched INTEGER,
          rating INTEGER
      )
      ''');
  }

  // Future<int> add(Anime anime) async {
  //   Database db = await instance.database;
  //   return await db.insert('groceries', anime.toMap());
  // }
  //
  // Future<int> remove(int id) async {
  //   Database db = await instance.database;
  //   return await db.delete('groceries', where: 'id = ?', whereArgs: [id]);
  // }
  //
  // Future<int> update(Anime anime) async {
  //   Database db = await instance.database;
  //   return await db.update('groceries', anime.toMap(),
  //       where: "id = ?", whereArgs: [anime.id]);
  // }
}