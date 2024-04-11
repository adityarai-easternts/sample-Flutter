import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dog.dart';

class DogDatabase {
  static final instance = DogDatabase();
  static late final Future<Database> _database;
  Future<void> initDatabase() async {
    debugPrint("Crating _database instance");
    _database = openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(name TEXT)',
        );
      },
      version: 2,
    );
  }

  Future<void> insertDog(Dog dog) async {
    debugPrint('trying to insert dog ${dog.name}');
    (await _database).insert('dogs', dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Dog>> dogs() async {
    final List<Map<String, Object?>> dogsMap =
        await (await _database).query('dogs');

    return [for (final {'name': name as String} in dogsMap) Dog(name: name)];
  }

  Future<void> removeDog(Dog dog) async {
    debugPrint("deleting dog ${dog.name}");
    await (await _database)
        .delete('dogs', where: 'name = ?', whereArgs: [dog.name]);
  }
}
