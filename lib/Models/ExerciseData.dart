import 'package:meta/meta.dart';
import 'package:gym_book/database/db.dart';

class ExerciseData {
  static final db_exercise = "exercise_id";
  static final db_workout = "workout_id";
  static final db_reps = "reps";
  static final db_sets = "sets";
  static final db_weight = "weight";
  static final db_distance = "distance";
  static final db_time = "time";
  static final db_id = "id";

  int id, workout, reps, sets, exercise;
  var weight, distance, time;
  ExerciseData({
    this.id = null,
    @required this.workout,
    @required this.exercise,
    this.reps = 0,
    this.sets = 0,
    this.weight = 0.0,
    this.distance = 0.0,
    this.time = 0.0,
  });

  ExerciseData.fromMap(Map<String, dynamic> map)
      : this(
          reps: map[db_reps],
          sets: map[db_sets],
          weight: map[db_weight],
          distance: map[db_distance],
          time: map[db_time],
          id: map[db_id],
          exercise: map[db_exercise],
          workout: map[db_workout],
        );

  Map<String, dynamic> toMap() {
    return {
      db_reps: reps,
      db_sets: sets,
      db_weight: weight,
      db_distance: distance,
      db_time: time,
      db_id: id,
      db_exercise: exercise,
      db_workout: workout,
    };
  }

  static getExercise(int i) async {
    return await db.get().getExercise('$i');
  }

  static getWorkout(int i) async {
    return await db.get().getWorkout('$i');
  }
}
