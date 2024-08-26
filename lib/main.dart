import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather/Model/DarkMode.dart';
import 'package:weather/database/DarkModeDB.dart';
import 'HomePage.dart';
import 'package:weather/Local_Notification.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.init();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  _MainApp createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  bool _isDarkMode = false;
  bool _isLoading = true;
  final darkmodedb = Darkmodedb();
  List<Darkmode> darkMode = [];
  Database? database;

  @override
  void initState() {
    super.initState();
    listenToNofications();
    fetchAll();
  }

  listenToNofications() {
    LocalNotification.onClickNotification.stream.listen((event) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(dark_mode: _isDarkMode)));
    });
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
}
