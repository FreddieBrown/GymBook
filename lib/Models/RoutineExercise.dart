import 'package:meta/meta.dart';
import 'package:gym_book/database/db.dart';

class RoutineExercise {
  static final db_exercise = "exercise_id";
  static final db_routine = "routine_id";
  static final db_id = "id";

  int id, routine, reps, sets, exercise;
  var weight, distance, time;
  RoutineExercise({
    this.id = null,
    @required this.routine,
    @required this.exercise,
  });

  RoutineExercise.fromMap(Map<String, dynamic> map)
      : this(
          id: map[db_id],
          exercise: map[db_exercise],
          routine: map[db_routine],
        );

  Map<String, dynamic> toMap() {
    return {
      db_id: id,
      db_exercise: exercise,
      db_routine: routine,
    };
  }

  static getRoutine(String i) async {
    return await db.get().getRoutine(i);
  }

  static getExercise(String i) async {
    var a = await db.get().getExercise(i);
    return a;
  }
}
