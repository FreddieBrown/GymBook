import 'package:meta/meta.dart';

class Workout {
  static final db_id = "id";
  static final db_name = "name";
  static final db_date = "date";

  int id;
  String name;
  String date;

  Workout({
    this.id = null,
    @required this.name,
    @required this.date,
  });

  Workout.fromMap(Map<String, dynamic> map): this(
    id: map[db_id],
    name: map[db_name],
    date: map[db_date],
  );

  // Currently not used
  Map<String, dynamic> toMap() {
    return {
      db_id: id,
      db_name: name,
      db_date: date,
    };
  }
}