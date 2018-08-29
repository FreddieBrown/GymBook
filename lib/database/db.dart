import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../Models/Exercise.dart';
import '../Models/Workout.dart';
import '../Models/Routine.dart';
import '../Models/RoutineExercise.dart';
class db {
  static final db _db = new db._internal();

  final String tableNameE = "Exercises";
  final String tableNameW = "Workouts";
  final String tableNameR = "Routines";
  final String tableNameRE = "RoutineExercises";

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
    String path = join(documentsDirectory.path, "demo.db");
    data = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              "CREATE TABLE $tableNameE ("
                  "${Exercise.db_id} INTEGER PRIMARY KEY AUTOINCREMENT,"
                  "${Exercise.db_name} VARCHAR(30) NOT NULL,"
                  "${Exercise.db_notes} TEXT NOT NULL"
                  ")");
          await db.execute(
              "CREATE TABLE $tableNameW ("
                  "${Workout.db_id} INTEGER PRIMARY KEY AUTOINCREMENT,"
                  "${Workout.db_name} VARCHAR(30) NOT NULL,"
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
                  "${RoutineExercise.db_reps} INTEGER NOT NULL,"
                  "${RoutineExercise.db_sets} INTEGER NOT NULL,"
                  "${RoutineExercise.db_weight} FLOAT NOT NULL,"
                  "${RoutineExercise.db_distance} FLOAT NOT NULL,"
                  "${RoutineExercise.db_time} FLOAT NOT NULL,"
                  "${RoutineExercise.db_exercise} INTEGER NOT NULL"
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


  Future updateExercise(Exercise exercise) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT OR REPLACE INTO '
            '$tableNameE(${Exercise.db_id}, ${Exercise.db_name}, ${Exercise.db_notes})'
            ' VALUES(?, ?, ?)',
        [exercise.id, exercise.name, exercise.notes]);
  }

  Future updateWorkout(Workout work) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT OR REPLACE INTO '
            '$tableNameW(${Workout.db_id}, ${Workout.db_name}, ${Workout.db_date})'
            ' VALUES(?, ?, ?)',
        [work.id, work.name, work.date]);
  }

  Future updateRoutineExercise(RoutineExercise exercise) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT OR REPLACE INTO '
            '$tableNameRE(${RoutineExercise.db_id}, ${RoutineExercise.db_reps}, ${RoutineExercise.db_sets}, ${RoutineExercise.db_weight}, ${RoutineExercise.db_distance}, ${RoutineExercise.db_time}, ${RoutineExercise.db_exercise})'
            ' VALUES(?, ?, ?, ?, ?, ?, ?)',
        [exercise.id, exercise.reps, exercise.sets, exercise.weight, exercise.distance, exercise.time, exercise.exercise]);
  }

  Future updateRoutine(Routine routine) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT OR REPLACE INTO '
            '$tableNameR(${Routine.db_id}, ${Routine.db_name})'
            ' VALUES(?, ?)',
        [routine.id, routine.name]);
  }


  Future close() async {
    var db = await _getDb();
    return db.close();
  }
}