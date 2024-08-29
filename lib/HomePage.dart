import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/Model/TodoTask.dart';
import 'package:weather/database/DarkModeDB.dart';
import 'package:weather/database/TodoTaskDB.dart';
import 'AddTask.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  bool dark_mode = false;

  HomePage({super.key, required this.dark_mode});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _backgroundColor = Colors.white;
  late bool _isDarkMode;
  final darkmodedb = Darkmodedb();

  final todo_task = Todotaskdb();
  List<Todotask>? todo_list;

  String? time_now;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.dark_mode;

    DateTime now = DateTime.now();
    time_now = '${now.day.toString()}/${now.month.toString()}/${now.year.toString()}';

    if (time_now != null) {
      searchbyday(time_now!);
    } else {
      print("time_now is null");
    }
  }


  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    final formattedDate = DateFormat('dd MMMM yyyy').format(now);

    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.grey[900] : _backgroundColor,
      body: SafeArea(
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
                          insertDarkmode(_isDarkMode);
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddTask(dark_mode: _isDarkMode,)));
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
                height: 110,
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
                    String change = date.day.toString() + '/' + date.month.toString() + '/' + date.year.toString();
                    setState(() {
                      time_now = change;
                    });
                    searchbyday(change);
                  },
                ),
              ),
              const SizedBox(height: 20,),
              (todo_list != null && todo_list!.length != 0) ? Expanded(
                child: ListView.builder(
                  itemCount: todo_list!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        popup(todo_list![index].title, todo_list![index].date, todo_list![index].status, time_now);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: todo_list![index].color == ''
                              ? Colors.blue
                              : Color(int.parse('0x' + todo_list![index].color.toString())),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    todo_list![index].title,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time, color: Colors.white, size: 20),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${todo_list![index].start} - ${todo_list![index].end}',
                                        style: GoogleFonts.lato(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    todo_list![index].description,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                margin: EdgeInsets.only(right: 10, bottom: todo_list![index].status == 'COMPLETE' ? 15 : 31),
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    todo_list![index].status,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ) : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  void insertDarkmode(bool dark_mode) async {
    if(dark_mode == false) {
      darkmodedb.upsertDarkMode(0);
    }
    else {
      darkmodedb.upsertDarkMode(1);
    }
  }

  void searchbyday(String timeNow) async {
    setState(() {
      todo_list = [];
    });
    try {
      List<Todotask> tasks = await todo_task.findbyday(timeNow);
      setState(() {
        todo_list = tasks;
      });
    } catch (e) {
      print("Error occurred in searchbyday: $e");
    }
  }

  void popup(String title, String date, String status, String? time) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 250,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  todo_task.updatestatus(date: date, title: title, status: 'COMPLETE');
                  Navigator.pop(context);
                  searchbyday(time!);
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Colors.purple),
                  child: Center(
                    child: Text(
                      'Task Complete',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  todo_task.deleteByDateAndTitle(date: date, title: title);
                  Navigator.pop(context);
                  searchbyday(time!);
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Colors.red[400]),
                  child: Center(
                    child: Text(
                      'Delete Task',
                      style: GoogleFonts.lato(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );

  }
}