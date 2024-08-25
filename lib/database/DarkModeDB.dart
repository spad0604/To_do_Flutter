import 'package:sqflite/sqflite.dart';
import 'DarkModeService.dart';
import 'package:weather/Model/DarkMode.dart';

class Darkmodedb {
  final tableName = 'dark_mode';

    Future<void> createTable(Database database) async {
      await database.execute('''
        CREATE TABLE IF NOT EXISTS $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          darkMode INTEGER NOT NULL
        );
      ''');
    }

  
  Future<int> create({required int darkMode}) async {
    final database = await Darkmodeservice().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (darkMode) VALUES (?) ''',
      [darkMode]
    );
  }

  Future<List<Darkmode>> fetchAll() async {
    final database = await Darkmodeservice().database;
    final darkMode = await database.rawQuery(
      '''SELECT * from $tableName'''
    );
    return darkMode.map((dark_mode) => Darkmode.fromSqfliteDatabase(dark_mode)).toList();
  }

Future<void> upsertDarkMode(int darkMode) async {
  final database = await Darkmodeservice().database;
  var count = Sqflite.firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM $tableName'));
  
  if (count == 0) {
    await database.insert(
      tableName,
      {'darkMode': darkMode},
    );
  } else {
    await database.update(
      tableName,
      {'darkMode': darkMode},
    );
  }
}

}