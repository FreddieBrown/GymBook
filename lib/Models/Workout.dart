import 'package:meta/meta.dart';

class Workout {
  static final db_id = "id";
  static final db_name = "name";
  static final db_date = "date";
  static final db_routine = "routine_id";

  int id, routine;
  String name;
  String date;

  Workout({
    this.id = null,
    @required this.routine,
    @required this.name,
    @required this.date,
  });

  Workout.fromMap(Map<String, dynamic> map): this(
    id: map[db_id],
    name: map[db_name],
    date: map[db_date],
    routine: map[db_routine],
  );

  // Currently not used
  Map<String, dynamic> toMap() {
    return {
      db_id: id,
      db_name: name,
      db_date: date,
      db_routine: routine,
    };
  }
}