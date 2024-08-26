import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/database/TodoTaskDB.dart';

class AddTask extends StatefulWidget {
  final bool dark_mode;

  const AddTask({super.key, required this.dark_mode});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  int _createsuccess = 0;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController_1 = TextEditingController();
  TextEditingController _timeController_2 = TextEditingController();
  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _taskDescription = TextEditingController();

  final todo_task = Todotaskdb();

  Color? _selectedColor, _mainColor;
  bool? _isDarkMode;
  bool _quit = false;

  void _setcolor(Color? value) {
    setState(() {
      _selectedColor = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.dark_mode;
    _isDarkMode! ? _mainColor = Colors.white : _mainColor = Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    _isDarkMode! ? _mainColor = Colors.white : _mainColor = Colors.black;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(_createsuccess == 1) {
        showToast(
          'Create Task Successfull!',
          context: context,
          animation: StyledToastAnimation.slideFromTop,
          reverseAnimation: StyledToastAnimation.slideToTop,
          position: StyledToastPosition.top,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        );
        _createsuccess = 0;
      }
      else if(_createsuccess == 2) {
        showToast(
          'Create Task UnSuccessfull!',
          context: context,
          animation: StyledToastAnimation.slideFromTop,
          reverseAnimation: StyledToastAnimation.slideToTop,
          position: StyledToastPosition.top,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        );
        _createsuccess = 0;
      }
    });
    return Stack(
      children: [
        Scaffold(
          backgroundColor: _isDarkMode! ? Colors.black : Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        print(_taskNameController.text);
                        if(_taskNameController.text == '' && _taskDescription.text == '') {
                          _quit = false;
                          Navigator.pop(context);
                        }
                        else {
                          _quit = true;
                        }
                      });
                    },
                    child: Container(
                      height: 34,
                      width: 34,
                      margin: const EdgeInsets.only(top: 10, left: 10), 
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(Icons.arrow_back, color: _mainColor),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                        'Add Task',
                        style: GoogleFonts.lato(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: _mainColor
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      'Task Name',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _mainColor
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: TextField(
                      controller: _taskNameController,
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: _mainColor,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter task name',
                        suffixIconColor: _mainColor,
                        iconColor: _mainColor,
                        hintStyle: GoogleFonts.lato
                          (fontSize: 15, fontWeight: FontWeight.normal, color: _mainColor),
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15),)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      'Task Description',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _mainColor
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: TextField(
                      controller: _taskDescription,
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: _mainColor,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter task description',
                        suffixIconColor: _mainColor,
                        iconColor: _mainColor,
                        hintStyle: GoogleFonts.lato(
                            fontSize: 15, fontWeight: FontWeight.normal, color: _mainColor
                        ),
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      'Date',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _mainColor
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: TextField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        hintText: 'Select Date',
                        suffixIconColor: _mainColor,
                        iconColor: _mainColor,
                        suffixIcon: const Icon(Icons.calendar_today),
                        hintStyle: GoogleFonts.lato
                          (fontSize: 15, fontWeight: FontWeight.normal, color: _mainColor),
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start Time',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: _mainColor,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              TextField(
                                controller: _timeController_1,
                                readOnly: true,
                                onTap: () => _selectTime(context, _timeController_1),
                                decoration: InputDecoration(
                                  suffixIconColor: _mainColor,
                                  iconColor: _mainColor,
                                  hintText: "Start",
                                  suffixIcon: const Icon(Icons.access_time),
                                  hintStyle: GoogleFonts.lato
                                    (fontSize: 15, fontWeight: FontWeight.normal, color: _mainColor),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'End Time',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: _mainColor,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              TextField(
                                readOnly: true,
                                controller: _timeController_2,
                                onTap: () => _selectTime(context, _timeController_2),
                                decoration: InputDecoration(
                                  suffixIconColor: _mainColor,
                                  iconColor: _mainColor,
                                  hintText: "End",
                                  suffixIcon: const Icon(Icons.access_time),
                                  hintStyle: GoogleFonts.lato(
                                    fontSize: 15, 
                                    fontWeight: FontWeight.normal,
                                    color: _mainColor
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      'Color',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _mainColor
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                          _buildColorOption(const Color(0xFFFFAE3B)),
                          const SizedBox(width: 10,),
                          _buildColorOption(const Color(0xFFF03957)),
                          const SizedBox(width: 10,),
                          _buildColorOption(const Color(0xFF4550E6)),
                          ]
                        ),
                        GestureDetector(
                          onTap: () {
                            CreateTask();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text(
                                'Create Task',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: _quit,
          child: Center(
            child: Container(
              height: 200,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), 
                        spreadRadius: 2,
                        blurRadius: 5, 
                        offset: const Offset(0, 4), 
                      ),
                    ],
                  ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 50,
                    child: const Text(
                      'Are you sure?',
                      style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.blue),
                            child: Center(
                              child: Text(
                                'YES',
                                style: GoogleFonts.lato(
                                  fontSize: 15,
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            _quit = false;
                          }),
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                'NO',
                                style: GoogleFonts.lato(
                                  fontSize: 15,
                                  color: Colors.blue
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  void _selectTime(BuildContext context, TextEditingController controller) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        controller.text = formatTimeOfDay(pickedTime);
      });
    }
  }


  Widget _buildColorOption(Color color) {
    bool isSelected = _selectedColor == color;
    return GestureDetector(
      onTap: () => _setcolor(color),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: _mainColor!, width: 2)
              : null,
        ),
        child: isSelected
            ? const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 24,
                ),
              )
            : null,
      ),
    );
  }

  String formatTimeOfDay(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  void CreateTask() async {
    bool _isOk = true;
    num time1 = 0, time2 = 0, minute1 = 0, minute2 = 0;
    
    time1 = int.parse(_timeController_1.text[0]) * 10 + int.parse(_timeController_1.text[1]);
    time2 = int.parse(_timeController_2.text[0]) * 10 + int.parse(_timeController_2.text[1]);

    minute1 = int.parse(_timeController_1.text[3]) * 10 + int.parse(_timeController_1.text[4]);
    minute2 = int.parse(_timeController_2.text[3]) * 10 + int.parse(_timeController_2.text[4]);

    if(time1 > time2) {
      _isOk = false;
    }
    else {
      if(time1 == time2) {
        if(minute1 > minute2) {
          _isOk = false;
        }
      }
    }

    if(_taskNameController.text != '' && _taskDescription.text != '' && _isOk) {
      todo_task.create(
        title: _taskNameController.text,
        description: _taskDescription.text,
        date: _dateController.text,
        start: _timeController_1.text,
        end: _timeController_2.text,
        color: colorToHex(_selectedColor!),
        status: 'TODO'
      );
      setState(() {
        _createsuccess = 1;
      });
    }
    else {
      setState(() {
        _createsuccess = 2;
      });
    }
  }

  String colorToHex(Color color) {
    return color.value.toRadixString(16).toUpperCase().padLeft(6, '0');
  }
}