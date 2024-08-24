import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 34,
                width: 34,
                margin: const EdgeInsets.only(top: 10, left: 10), 
                child: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              child: Text(
                  'Add Task',
                  style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              child: Text(
                'Task Name',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.normal
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter task name',
                  hintStyle: GoogleFonts.lato
                    (fontSize: 15, fontWeight: FontWeight.normal),
                  border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              child: Text(
                'Task Description',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.normal
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter task description',
                  hintStyle: GoogleFonts.lato
                    (fontSize: 15, fontWeight: FontWeight.normal),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}