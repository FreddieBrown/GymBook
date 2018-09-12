import 'package:meta/meta.dart';
import 'package:gym_book/database/db.dart';

class Workout {
  static final db_id = "id";
  static final db_name = "name";
  static final db_date = "date";
  static final db_routine = "routine_id";
  static final db_user = "user_id";
  static final db_status = "status";

  int id, routine, user, status;
  String name;
  String date;

  Workout({
    this.id = null,
    @required this.routine,
    @required this.user,
    @required this.name,
    @required this.date,
    this.status = 0,
  });

  Workout.fromMap(Map<String, dynamic> map)
      : this(
          id: map[db_id],
          user: map[db_user],
          name: map[db_name],
          date: map[db_date],
          routine: map[db_routine],
          status: map[db_status],
        );

  Map<String, dynamic> toMap() {
    return {
      db_id: id,
      db_user: user,
      db_name: name,
      db_date: date,
      db_routine: routine,
      db_status: status,
    };
  }

  static getRoutine(int i) async {
    return await db.get().getRoutine('$i');
  }
}
