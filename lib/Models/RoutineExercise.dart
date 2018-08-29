import 'package:meta/meta.dart';

class RoutineExercise {
  static final db_exercise = "exercise_id";
  static final db_routine = "routine_id";
  static final db_reps = "reps";
  static final db_sets = "sets";
  static final db_weight = "weight";
  static final db_distance = "distance";
  static final db_time = "time";
  static final db_id = "id";

  int id, routine, reps, sets, exercise;
  var weight, distance, time;
  RoutineExercise({
    this.id = null,
    @required this.routine,
    @required this.exercise,
    this.reps = 0,
    this.sets = 0,
    this.weight = 0.0,
    this.distance = 0.0,
    this.time = 0.0,
  });

  RoutineExercise.fromMap(Map<String, dynamic> map): this(
    reps: map[db_reps],
    sets: map[db_sets],
    weight: map[db_weight],
    distance: map[db_distance],
    time: map[db_time],
    id: map[db_id],
    exercise: map[db_exercise],
    routine: map[db_routine],
  );

  // Currently not used
  Map<String, dynamic> toMap() {
    return {
      db_reps: reps,
      db_sets: sets,
      db_weight: weight,
      db_distance: distance,
      db_time: time,
      db_id: id,
      db_exercise: exercise,
      db_routine: routine,
    };
  }
}