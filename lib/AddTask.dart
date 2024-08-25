import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTask extends StatefulWidget {
  final bool dark_mode;

  const AddTask({super.key, required this.dark_mode});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

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
                        _quit = true;
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
                      decoration: InputDecoration(
                        hintText: 'Enter task description',
                        suffixIconColor: _mainColor,
                        iconColor: _mainColor,
                        hintStyle: GoogleFonts.lato
                          (fontSize: 15, fontWeight: FontWeight.normal, color: _mainColor),
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
                                controller: _timeController,
                                readOnly: true,
                                onTap: () => _selectTime(context),
                                decoration: InputDecoration(
                                  suffixIconColor: _mainColor,
                                  iconColor: _mainColor,
                                  hintText: "10:41",
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
                                controller: _timeController,
                                onTap: () => _selectTime(context),
                                decoration: InputDecoration(
                                  suffixIconColor: _mainColor,
                                  iconColor: _mainColor,
                                  hintText: "11:41",
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
                          _buildColorOption(Colors.red),
                          const SizedBox(width: 10,),
                          _buildColorOption(Colors.yellow),
                          const SizedBox(width: 10,),
                          _buildColorOption(Colors.purple),
                          ]
                        ),
                        GestureDetector(
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
                    child: const Text(
                      'Are you sure?',
                      style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)
                    ),
                  ),
                  Column(
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
                  )
                ],
              ),
            ),
          ),
        )
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

    Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
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
}