import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../Models/Exercise.dart';
import '../Models/Workout.dart';
import '../Models/Routine.dart';
import '../Models/RoutineExercise.dart';
import '../Models/ExerciseData.dart';
class db {
  static final db _db = new db._internal();

  final String tableNameE = "Exercises";
  final String tableNameW = "Workouts";
  final String tableNameR = "Routines";
  final String tableNameRE = "RoutineExercises";
  final String tableNameED = "ExerciseData";

  Database data;

  bool didInit = false;

  static db get() {
    return _db;
  }

  db._internal();

  Future<Database> _getDb() async{
    if(!didInit) await _init();
    return data;
  }

  Future init() async {
    return await _init();
  }


  Future _init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "gym.db");
    data = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              "CREATE TABLE $tableNameE ("
                  "${Exercise.db_id} INTEGER PRIMARY KEY AUTOINCREMENT,"
                  "${Exercise.db_name} VARCHAR(30) NOT NULL,"
                  "${Exercise.db_notes} TEXT NOT NULL,"
                  "${Exercise.db_flag} INTEGER NOT NULL"
                  ")");
          await db.execute(
              "CREATE TABLE $tableNameW ("
                  "${Workout.db_id} INTEGER PRIMARY KEY AUTOINCREMENT,"
                  "${Workout.db_name} VARCHAR(30) NOT NULL,"
                  "${Workout.db_routine} INTEGER NOT NULL,"
                  "${Workout.db_date} TEXT NOT NULL"
                  ")");
          await db.execute(
              "CREATE TABLE $tableNameR ("
                  "${Routine.db_id} INTEGER PRIMARY KEY AUTOINCREMENT,"
                  "${Routine.db_name} VARCHAR(30) NOT NULL"
                  ")");
          await db.execute(
              "CREATE TABLE $tableNameRE ("
                  "${RoutineExercise.db_id} INTEGER PRIMARY KEY AUTOINCREMENT,"
                  "${RoutineExercise.db_exercise} INTEGER NOT NULL,"
                  "${RoutineExercise.db_routine} INTEGER NOT NULL"
                  ")");
          await db.execute(
              "CREATE TABLE $tableNameED ("
                  "${ExerciseData.db_id} INTEGER PRIMARY KEY AUTOINCREMENT,"
                  "${ExerciseData.db_reps} INTEGER NOT NULL,"
                  "${ExerciseData.db_sets} INTEGER NOT NULL,"
                  "${ExerciseData.db_weight} FLOAT NOT NULL,"
                  "${ExerciseData.db_distance} FLOAT NOT NULL,"
                  "${ExerciseData.db_time} FLOAT NOT NULL,"
                  "${ExerciseData.db_workout} INTEGER NOT NULL,"
                  "${ExerciseData.db_exercise} INTEGER NOT NULL"
                  ")");
          /// This is where all DB creation happens.
        });
    didInit = true;
  }


  Future<List<Exercise>> getExercises([List<String> ids = null]) async{
    var db = await _getDb();
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<Exercise> exercises = [];
    if(ids == null) {
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameE');
      for (Map<String, dynamic> item in result) {
        exercises.add(new Exercise.fromMap(item));
      }
      return exercises;
    }
    else{
      var idsString = ids.map((it) => '"$it"').join(',');
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameE WHERE ${Exercise.db_id} IN ($idsString)');
      for (Map<String, dynamic> item in result) {
        exercises.add(new Exercise.fromMap(item));
      }
      return exercises;
    }
  }

  Future<List<Workout>> getWorkouts([List<String> ids = null]) async{
    var db = await _getDb();
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<Workout> workouts = [];
    if(ids == null){
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameW');
      for (Map<String, dynamic> item in result) {
        workouts.add(new Workout.fromMap(item));
      }
      return workouts;
    }
    else {
      var idsString = ids.map((it) => '"$it"').join(',');
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameW WHERE ${Workout.db_id} IN ($idsString)');
      for (Map<String, dynamic> item in result) {
        workouts.add(new Workout.fromMap(item));
      }
      return workouts;
    }
  }

  Future<List<Routine>> getRoutines([List<String> ids = null]) async{
    var db = await _getDb();
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<Routine> routines = [];
    if(ids == null){
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameR');
      for (Map<String, dynamic> item in result) {
        routines.add(new Routine.fromMap(item));
      }
      return routines;
    }
    else {
      var idsString = ids.map((it) => '"$it"').join(',');
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameR WHERE ${Routine.db_id} IN ($idsString)');
      for (Map<String, dynamic> item in result) {
        routines.add(new Routine.fromMap(item));
      }
      return routines;
    }
  }

  Future<List<RoutineExercise>> getRoutineExercises([List<String> ids = null]) async{
    var db = await _getDb();
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<RoutineExercise> exercises = [];
    if(ids == null){
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameRE');
      for (Map<String, dynamic> item in result) {
        exercises.add(new RoutineExercise.fromMap(item));
      }
      return exercises;
    }
    else {
      var idsString = ids.map((it) => '"$it"').join(',');
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameRE WHERE ${RoutineExercise.db_id} IN ($idsString)');
      for (Map<String, dynamic> item in result) {
        exercises.add(new RoutineExercise.fromMap(item));
      }
      return exercises;
    }
  }


  Future<Exercise> getExercise(String id) async{
    var result = await data.rawQuery('SELECT * FROM $tableNameE WHERE ${Exercise.db_id} = "$id"');
    if(result.length == 0)return null;
    return new Exercise.fromMap(result[0]);
  }

  Future<Workout> getWorkout(String id) async{
    var result = await data.rawQuery('SELECT * FROM $tableNameW WHERE ${Workout.db_id} = "$id"');
    if(result.length == 0)return null;
    return new Workout.fromMap(result[0]);
  }

  Future<RoutineExercise> getRoutineExercise(String id) async{
    var result = await data.rawQuery('SELECT * FROM $tableNameRE WHERE ${RoutineExercise.db_id} = "$id"');
    if(result.length == 0)return null;
    return new RoutineExercise.fromMap(result[0]);
  }

  Future<Routine> getRoutine(String id) async{
    var result = await data.rawQuery('SELECT * FROM $tableNameR WHERE ${Routine.db_id} = "$id"');
    if(result.length == 0)return null;
    return new Routine.fromMap(result[0]);
  }

  Future<ExerciseData> getExerciseData(String id) async{
    var result = await data.rawQuery('SELECT * FROM $tableNameED WHERE ${ExerciseData.db_id} = "$id"');
    if(result.length == 0)return null;
    return new ExerciseData.fromMap(result[0]);
  }


  Future updateExercise(Exercise exercise) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT OR REPLACE INTO '
            '$tableNameE(${Exercise.db_id}, ${Exercise.db_name}, ${Exercise.db_notes}, ${Exercise.db_flag})'
            ' VALUES(?, ?, ?, ?)',
        [exercise.id, exercise.name, exercise.notes, exercise.flag]);
  }

  Future updateWorkout(Workout work) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT OR REPLACE INTO '
            '$tableNameW(${Workout.db_id}, ${Workout.db_name}, ${Workout.db_date}, ${Workout.db_routine})'
            ' VALUES(?, ?, ?, ?)',
        [work.id, work.name, work.date, work.routine]);
  }

  Future updateRoutineExercise(RoutineExercise exercise) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT OR REPLACE INTO '
            '$tableNameRE(${RoutineExercise.db_id}, ${RoutineExercise.db_exercise}, ${RoutineExercise.db_routine})'
            ' VALUES(?, ?, ?)',
        [exercise.id, exercise.exercise, exercise.routine]);
  }

  Future updateRoutine(Routine routine) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT OR REPLACE INTO '
            '$tableNameR(${Routine.db_id}, ${Routine.db_name})'
            ' VALUES(?, ?)',
        [routine.id, routine.name]);
  }

  Future updateExerciseData(ExerciseData ed) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT OR REPLACE INTO '
            '$tableNameED(${ExerciseData.db_id}, ${ExerciseData.db_exercise}, ${ExerciseData.db_workout}, ${ExerciseData.db_time}, ${ExerciseData.db_distance}, ${ExerciseData.db_weight}, ${ExerciseData.db_reps}, ${ExerciseData.db_sets})'
            ' VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
        [ed.id, ed.exercise, ed.workout, ed.time, ed.distance, ed.weight, ed.reps, ed.sets]);
  }


  Future close() async {
    var db = await _getDb();
    return db.close();
  }
}