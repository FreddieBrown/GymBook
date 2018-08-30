import 'package:meta/meta.dart';

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

  RoutineExercise.fromMap(Map<String, dynamic> map): this(
    id: map[db_id],
    exercise: map[db_exercise],
    routine: map[db_routine],
  );

  // Currently not used
  Map<String, dynamic> toMap() {
    return {
      db_id: id,
      db_exercise: exercise,
      db_routine: routine,
    };
  }
}