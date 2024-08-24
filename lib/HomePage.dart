import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'AddTask.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _backgroundColor = Colors.white;
  late bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    final formattedDate = DateFormat('dd MMMM yyyy').format(now);

    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.grey[900] : _backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isDarkMode = !_isDarkMode;
                          });
                        },
                        child: Icon(
                          _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          size: 30,
                          color: _isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, right: 10),
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: _isDarkMode ? Colors.white : Colors.grey[900],
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formattedDate,
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              color: _isDarkMode ? Colors.white : Colors.grey[600],
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'Today',
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              color: _isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTask()));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add, color: Colors.white),
                                const SizedBox(width: 5), 
                                Text(
                                  'Add Task',
                                  style: GoogleFonts.lato(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 95,
                  margin: const EdgeInsets.only(top: 20),
                  child: DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.purple,
                    selectedTextColor: Colors.white,
                    monthTextStyle: GoogleFonts.lato(
                      color: _isDarkMode ? Colors.white : Colors.grey,
                    ),
                    dayTextStyle: GoogleFonts.lato(
                      color: _isDarkMode ? Colors.white : Colors.grey,
                    ),
                    dateTextStyle: GoogleFonts.lato(
                      fontSize: 20,
                      color: _isDarkMode ? Colors.white :  Colors.grey,
                    ),
                    onDateChange: (date) {
                      print('Selected date: $date');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}