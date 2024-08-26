import 'package:floor/floor.dart';

class Todotask {

  final String title;
  
  final String description;

  final String date;

  final String start;

  final String end;

  final String color;

  final String status;

  const Todotask({required this.title, required this.description, required this.date, required this.start, required this.end, required this.color, required this.status});

  factory Todotask.fromSqfliteDatabase(Map<String, dynamic> map) => Todotask(
    title: map['title'],
    description: map['description'],
    date: map['date'],
    start: map['start'],
    end: map['end'],
    color: map['color'],
    status: map['status']
  );
}