import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather/Model/DarkMode.dart';
import 'package:weather/Model/TodoTask.dart';
import 'package:weather/database/DarkModeDB.dart';
import 'package:weather/database/TodoTaskDB.dart';
import 'HomePage.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:weather/Local_Notification.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.init();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainApp createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  bool _isDarkMode = false;
  bool _isLoading = true;
  final darkmodedb = Darkmodedb();
  List<Darkmode> darkMode = [];

  List<Todotask> todo_list = [];
  final todotask_db = Todotaskdb();

  Database? database;

  @override
  void initState() {
    super.initState();
    fetchAll();
    getDataTodo();
  }

  @override
  Widget build(BuildContext context) {
    if(_isLoading == false) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: HomePage(dark_mode: _isDarkMode,),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

void fetchAll() async {
  darkMode = await darkmodedb.fetchAll();
  if (darkMode.isEmpty) {
    await darkmodedb.create(darkMode: 0);
    _isDarkMode = false;
  } else {
    setState(() {
      if (darkMode[darkMode.length - 1].isDarkMode == 1) {
        _isDarkMode = true;
      } else {
        _isDarkMode = false;
      }
    });
  }
  setState(() {
    _isLoading = false;
    });
  }

  void getDataTodo() async {
    todo_list = await todotask_db.fetchAll();
    for(int i = 0; i < todo_list.length; i++) {
      int dd1 = 0;
      num day = 0, month = 0, year = 0, hour = 0, minute = 0;
      for(int j = 0; j < todo_list[i].date.length; j++) {
        if(todo_list[i].date[j] == '/') {
          for(int k = j - 1; k >= 0; k--) {
            if(todo_list[i].date[k] == '/') {
              break;
            }
            else {
              if(dd1 == 0) {
                day = day + int.parse(todo_list[i].date[k]) * pow(10, j - k - 1);
              }
              if(dd1 == 1) {
                month = month + int.parse(todo_list[i].date[k]) * pow(10, j - k - 1);
              }
            }
          }
          dd1++;
        }
        if(j == todo_list[i].date.length - 1) {
          for(int k = j; k >= 0; k--) {
            if(todo_list[i].date[k] == '/') {
              break;
            }
            else {
              year = year + int.parse(todo_list[i].date[k]) * pow(10, j - k);
            }
          }
        }
      }
      hour = hour + int.parse(todo_list[i].start[0]) * 10 + int.parse(todo_list[i].start[1]);
      minute = minute + int.parse(todo_list[i].start[3]) * 10 + int.parse(todo_list[i].start[4]);

      final tz.TZDateTime time_now = tz.TZDateTime.now(tz.local);
      DateTime scheduledDateTime = DateTime(
          year.toInt(), month.toInt(), day.toInt(), hour.toInt(),
          minute.toInt());

      if(scheduledDateTime.isAfter(time_now)) {
        LocalNotification.scheduledNotification(
            todo_list[i].title, todo_list[i].description, scheduledDateTime);
      }
    }
  }
}
