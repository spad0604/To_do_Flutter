import 'package:sqflite/sqflite.dart';
import 'package:weather/Model/TodoTask.dart';
import 'package:weather/database/TodoTaskService.dart';

class Todotaskdb {
  final tableName = 'todo_Task';

  Future<void> createTable(Database database) async {
    await database.execute(
      '''
        CREATE TABLE IF NOT EXISTS $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          date TEXT NOT NULL,
          start TEXT NOT NULL,
          end TEXT NOT NULL,
          color TEXT NOT NULL,
          status TEXT NOT NULL
        ) 
      '''
    );
  }

  Future<int> create({required String title, required String description, required String date, required String start, required String end, required String color, required String status}) async{
    final database = await Todotaskservice().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (title, description, date, start, end, color, status) VALUES (?, ?, ?, ?, ?, ?, ?) ''',
      [title, description, date, start, end, color, status]
    );
  }

  Future<List<Todotask>> findbyday(String day) async {
    final database = await Todotaskservice().database;
    final todoTasks = await database.rawQuery(
      '''SELECT * from $tableName WHERE date = ?''',
      [day]
    );
    return todoTasks.map((todo) => Todotask.fromSqfliteDatabase(todo)).toList();
  }

  Future<int> deleteByDateAndTitle({required String date, required String title}) async {
    final database = await Todotaskservice().database;
    return await database.rawDelete(
      '''DELETE FROM $tableName WHERE date = ? AND title = ?''',
      [date, title]
    );
  }

  Future<int> updatestatus({required String date, required String title , required String status}) async{
    final database = await Todotaskservice().database;
    return await database.rawUpdate(
      '''UPDATE $tableName SET status = ? WHERE date = ? and title = ?''',
      [status, date, title]
    );
  }
}