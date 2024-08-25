import 'package:floor/floor.dart';

class Darkmode {
  @ColumnInfo(name: 'darkMode')
  final int isDarkMode;

  const Darkmode({required this.isDarkMode});

  factory Darkmode.fromSqfliteDatabase(Map<String, dynamic> map) => Darkmode(
    isDarkMode: map['darkMode']
    );
}