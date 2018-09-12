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
import '../Models/User.dart';
import '../Models/Status.dart';

class db {
  static final db _db = new db._internal();

  final String tableNameE = "Exercises";
  final String tableNameW = "Workouts";
  final String tableNameR = "Routines";
  final String tableNameRE = "RoutineExercises";
  final String tableNameED = "ExerciseData";
  final String tableNameU = "users";
  final String tableNameS = "status";

  Database data;

  bool didInit = false;
  bool addedAlter = false;

  static db get() {
    return _db;
  }

  db._internal();

  Future<Database> _getDb() async {
    if (!didInit) await _init();
    if (!addedAlter) await updateDB();
    return data;
  }

  Future init() async {
    return await _init();
  }

  Future _init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "gymb.db");
    data = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute("CREATE TABLE $tableNameE ("
          "${Exercise.db_id} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Exercise.db_name} VARCHAR(30) NOT NULL,"
          "${Exercise.db_notes} TEXT NOT NULL,"
          "${Exercise.db_flag} INTEGER NOT NULL"
          ")");
      await db.execute("CREATE TABLE $tableNameR ("
          "${Routine.db_id} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Routine.db_user} INTEGER NOT NULL,"
          "${Routine.db_name} VARCHAR(30) NOT NULL,"
          "FOREIGN KEY (${Routine.db_user}) REFERENCES ${tableNameU}(${User.db_id})"
          ")");
      await db.execute("CREATE TABLE $tableNameW ("
          "${Workout.db_id} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Workout.db_name} VARCHAR(30) NOT NULL,"
          "${Workout.db_routine} INTEGER NOT NULL,"
          "${Workout.db_user} INTEGER NOT NULL,"
          "${Workout.db_date} TEXT NOT NULL,"
          "FOREIGN KEY (${Workout.db_routine}) REFERENCES ${tableNameR}(${Routine.db_id}),"
          "FOREIGN KEY (${Workout.db_user}) REFERENCES ${tableNameU}(${User.db_id})"
          ")");
      await db.execute("CREATE TABLE $tableNameRE ("
          "${RoutineExercise.db_id} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${RoutineExercise.db_exercise} INTEGER NOT NULL,"
          "${RoutineExercise.db_routine} INTEGER NOT NULL,"
          "FOREIGN KEY (${RoutineExercise.db_routine}) REFERENCES ${tableNameR}(${Routine.db_id}),"
          "FOREIGN KEY (${RoutineExercise.db_exercise}) REFERENCES ${tableNameE}(${Exercise.db_id})"
          ")");
      await db.execute("CREATE TABLE $tableNameED ("
          "${ExerciseData.db_id} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${ExerciseData.db_reps} INTEGER NOT NULL,"
          "${ExerciseData.db_sets} INTEGER NOT NULL,"
          "${ExerciseData.db_weight} FLOAT NOT NULL,"
          "${ExerciseData.db_distance} FLOAT NOT NULL,"
          "${ExerciseData.db_time} FLOAT NOT NULL,"
          "${ExerciseData.db_workout} INTEGER NOT NULL,"
          "${ExerciseData.db_exercise} INTEGER NOT NULL,"
          "FOREIGN KEY (${ExerciseData.db_workout}) REFERENCES ${tableNameW}(${Workout.db_id}),"
          "FOREIGN KEY (${ExerciseData.db_exercise}) REFERENCES ${tableNameE}(${Exercise.db_id})"
          ")");
      await db.execute("CREATE TABLE $tableNameU ("
          "${User.db_id} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${User.db_name} VARCHAR(30) NOT NULL,"
          "${User.db_email} VARCHAR(30) NOT NULL,"
          "${User.db_salt} TEXT NOT NULL,"
          "${User.db_hashp} TEXT NOT NULL,"
          "${User.db_dev} INTEGER NOT NULL"
          ")");
      await db.execute("CREATE TABLE $tableNameS ("
          "${Status.db_id} INTEGER,"
          "FOREIGN KEY (${Status.db_id}) REFERENCES ${tableNameU}(${User.db_id})"
          ")");
      await db.execute("ALTER TABLE $tableNameW "
          "ADD COLUMN ${Workout.db_status} INTEGER");
      await db.execute("ALTER TABLE $tableNameE "
          "ADD COLUMN ${Exercise.db_user} INTEGER");

      /// This is where all DB creation happens.
    });
    addedAlter = true;
    didInit = true;
  }

  updateDB() async {
    await data.execute("ALTER TABLE $tableNameW "
        "ADD COLUMN ${Workout.db_status} INTEGER");
    await data.execute("ALTER TABLE $tableNameE "
        "ADD COLUMN ${Exercise.db_user} INTEGER");
    addedAlter = true;
  }

  Future<List<Exercise>> getExercises([List<String> ids = null]) async {
    var db = await _getDb();
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<Exercise> exercises = [];
    if (ids == null) {
      var result = await db.rawQuery('SELECT * FROM $tableNameE');
      for (Map<String, dynamic> item in result) {
        exercises.add(new Exercise.fromMap(item));
      }
      return exercises;
    } else {
      var idsString = ids.map((it) => '"$it"').join(',');
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameE WHERE ${Exercise.db_id} IN ($idsString)');
      for (Map<String, dynamic> item in result) {
        exercises.add(new Exercise.fromMap(item));
      }
      return exercises;
    }
  }

  Future<List<Workout>> getWorkouts([List<String> ids = null]) async {
    var db = await _getDb();
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<Workout> workouts = [];
    if (ids == null) {
      var result = await db.rawQuery('SELECT * FROM $tableNameW');
      for (Map<String, dynamic> item in result) {
        workouts.add(new Workout.fromMap(item));
      }
      return workouts;
    } else {
      var idsString = ids.map((it) => '"$it"').join(',');
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameW WHERE ${Workout.db_id} IN ($idsString)');
      for (Map<String, dynamic> item in result) {
        workouts.add(new Workout.fromMap(item));
      }
      return workouts;
    }
  }

  Future<List<Routine>> getRoutines([List<String> ids = null]) async {
    var db = await _getDb();
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<Routine> routines = [];
    if (ids == null) {
      var result = await db.rawQuery('SELECT * FROM $tableNameR');
      for (Map<String, dynamic> item in result) {
        routines.add(new Routine.fromMap(item));
      }
      return routines;
    } else {
      var idsString = ids.map((it) => '"$it"').join(',');
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameR WHERE ${Routine.db_id} IN ($idsString)');
      for (Map<String, dynamic> item in result) {
        routines.add(new Routine.fromMap(item));
      }
      return routines;
    }
  }

  Future<List<RoutineExercise>> getRoutineExercises(
      [List<String> ids = null]) async {
    var db = await _getDb();
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<RoutineExercise> exercises = [];
    if (ids == null) {
      var result = await db.rawQuery('SELECT * FROM $tableNameRE');
      for (Map<String, dynamic> item in result) {
        exercises.add(new RoutineExercise.fromMap(item));
      }
      return exercises;
    } else {
      var idsString = ids.map((it) => '"$it"').join(',');
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameRE WHERE ${RoutineExercise.db_id} IN ($idsString)');
      for (Map<String, dynamic> item in result) {
        exercises.add(new RoutineExercise.fromMap(item));
      }
      return exercises;
    }
  }

  Future<List<User>> getUsers([List<String> ids = null]) async {
    var db = await _getDb();
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<User> users = [];
    if (ids == null) {
      var result = await db.rawQuery('SELECT * FROM $tableNameU');
      for (Map<String, dynamic> item in result) {
        users.add(new User.fromMap(item));
      }
      return users;
    } else {
      var idsString = ids.map((it) => '"$it"').join(',');
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameU WHERE ${User.db_id} IN ($idsString)');
      for (Map<String, dynamic> item in result) {
        users.add(new User.fromMap(item));
      }
      return users;
    }
  }

  Future<List<Routine>> getRoutinesByUser([List<String> ids = null]) async {
    var db = await _getDb();
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<Routine> routines = [];
    if (ids == null) {
      var result = await db.rawQuery('SELECT * FROM $tableNameR');
      for (Map<String, dynamic> item in result) {
        routines.add(new Routine.fromMap(item));
      }
      return routines;
    } else {
      var idsString = ids.map((it) => '"$it"').join(',');
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameR WHERE ${Routine.db_user} IN ($idsString)');
      for (Map<String, dynamic> item in result) {
        routines.add(new Routine.fromMap(item));
      }
      return routines;
    }
  }

  Future<List<Exercise>> getExercisesByUser([List<String> ids = null]) async {
    var db = await _getDb();
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<Exercise> exercises = [];
    if (ids == null) {
      var result = await db.rawQuery('SELECT * FROM $tableNameE');
      for (Map<String, dynamic> item in result) {
        exercises.add(new Exercise.fromMap(item));
      }
      return exercises;
    } else {
      var idsString = ids.map((it) => '"$it"').join(',');
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameE WHERE ${Exercise.db_user} IN ($idsString)');
      for (Map<String, dynamic> item in result) {
        exercises.add(new Exercise.fromMap(item));
      }
      return exercises;
    }
  }

  Future<List<Workout>> getWorkoutsByUser([List<String> ids = null]) async {
    var db = await _getDb();
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<Workout> workouts = [];
    if (ids == null) {
      var result = await db.rawQuery('SELECT * FROM $tableNameW');
      for (Map<String, dynamic> item in result) {
        workouts.add(new Workout.fromMap(item));
      }
      return workouts;
    } else {
      var idsString = ids.map((it) => '"$it"').join(',');
      var result = await db.rawQuery(
          'SELECT * FROM $tableNameW WHERE ${Workout.db_user} IN ($idsString)');
      for (Map<String, dynamic> item in result) {
        workouts.add(new Workout.fromMap(item));
      }
      return workouts;
    }
  }

  Future<Exercise> getExercise(String id) async {
    var db = await _getDb();
    var result = await db
        .rawQuery('SELECT * FROM $tableNameE WHERE ${Exercise.db_id} = "$id"');
    if (result.length == 0) return null;
    return new Exercise.fromMap(result[0]);
  }

  Future<Workout> getWorkout(String id) async {
    var db = await _getDb();
    var result = await db
        .rawQuery('SELECT * FROM $tableNameW WHERE ${Workout.db_id} = "$id"');
    if (result.length == 0) return null;
    return new Workout.fromMap(result[0]);
  }

  Future<RoutineExercise> getRoutineExercise(String id) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM $tableNameRE WHERE ${RoutineExercise.db_id} = "$id"');
    if (result.length == 0) return null;
    return new RoutineExercise.fromMap(result[0]);
  }

  Future<User> getUser(String id) async {
    var db = await _getDb();
    var result = await db
        .rawQuery('SELECT * FROM $tableNameU WHERE ${User.db_id} = "$id"');
    if (result.length == 0) return null;
    return new User.fromMap(result[0]);
  }

  Future<Status> getStatus() async {
    var db = await _getDb();
    var result = await db.rawQuery('SELECT * FROM $tableNameS');
    if (result.length == 0) return null;
    return new Status.fromMap(result[0]);
  }

  Future<User> getUserByEmail(String email) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM $tableNameU WHERE ${User.db_email} = "$email"');
    if (result.length == 0) return null;
    return new User.fromMap(result[0]);
  }

  Future<List> getREByRoutine(String id) async {
    var db = await _getDb();
    var exercises = [];
    var result = await db.rawQuery(
        'SELECT * FROM $tableNameRE WHERE ${RoutineExercise.db_routine} = "$id"');
    if (result.length == 0) return null;
    for (Map<String, dynamic> item in result) {
      exercises.add(new RoutineExercise.fromMap(item));
    }
    return exercises;
  }

  Future<List> getEDByWorkout(String id) async {
    var db = await _getDb();
    var exercises = [];
    var result = await db.rawQuery(
        'SELECT * FROM $tableNameED WHERE ${ExerciseData.db_workout} = "$id"');
    if (result.length == 0) return null;
    for (Map<String, dynamic> item in result) {
      exercises.add(new ExerciseData.fromMap(item));
    }
    return exercises;
  }

  Future<List> getWorkoutByDate(String s) async {
    var db = await _getDb();
    var workouts = [];
    var result = await db
        .rawQuery('SELECT * FROM $tableNameW WHERE ${Workout.db_date} = "$s"');
    if (result.length == 0) return null;
    for (Map<String, dynamic> item in result) {
      workouts.add(new Workout.fromMap(item));
    }
    return workouts;
  }

  Future<Routine> getRoutine(String id) async {
    var db = await _getDb();
    var result = await db
        .rawQuery('SELECT * FROM $tableNameR WHERE ${Routine.db_id} = "$id"');
    if (result.length == 0) return null;
    return new Routine.fromMap(result[0]);
  }

  Future<ExerciseData> getExerciseData(String id) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM $tableNameED WHERE ${ExerciseData.db_id} = "$id"');
    if (result.length == 0) return null;
    return new ExerciseData.fromMap(result[0]);
  }

  Future updateExercise(Exercise exercise) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT OR REPLACE INTO '
        '$tableNameE(${Exercise.db_id}, ${Exercise.db_name}, ${Exercise.db_notes}, ${Exercise.db_flag}, ${Exercise.db_user})'
        ' VALUES(?, ?, ?, ?, ?)',
        [
          exercise.id,
          exercise.name,
          exercise.notes,
          exercise.flag,
          exercise.user
        ]);
  }

  Future updateWorkout(Workout work) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT OR REPLACE INTO '
        '$tableNameW(${Workout.db_id}, ${Workout.db_name}, ${Workout.db_date}, ${Workout.db_routine}, ${Workout.db_user}, ${Workout.db_status})'
        ' VALUES(?, ?, ?, ?, ?, ?)',
        [work.id, work.name, work.date, work.routine, work.user, work.status]);
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
        '$tableNameR(${Routine.db_id}, ${Routine.db_name}, ${Routine.db_user})'
        ' VALUES(?, ?, ?)',
        [routine.id, routine.name, routine.user]);
  }

  Future updateExerciseData(ExerciseData ed) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT OR REPLACE INTO '
        '$tableNameED(${ExerciseData.db_id}, ${ExerciseData.db_exercise}, ${ExerciseData.db_workout}, ${ExerciseData.db_time}, ${ExerciseData.db_distance}, ${ExerciseData.db_weight}, ${ExerciseData.db_reps}, ${ExerciseData.db_sets})'
        ' VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
        [
          ed.id,
          ed.exercise,
          ed.workout,
          ed.time,
          ed.distance,
          ed.weight,
          ed.reps,
          ed.sets
        ]);
  }

  Future updateUser(User user) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT OR REPLACE INTO '
        '$tableNameU(${User.db_id}, ${User.db_name}, ${User.db_email}, ${User.db_salt}, ${User.db_hashp}, ${User.db_dev})'
        ' VALUES(?, ?, ?, ?, ?, ?)',
        [user.id, user.name, user.email, user.salt, user.hashp, user.dev]);
  }

  Future updateStatus(Status status) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT OR REPLACE INTO '
        '$tableNameS(${Status.db_id})'
        ' VALUES(?)',
        [status.id]);
  }

  Future close() async {
    var db = await _getDb();
    return db.close();
  }

  void removeRoutineExercise(int id) async {
    var db = await _getDb();
    await db.rawQuery(
        'DELETE FROM $tableNameRE WHERE ${RoutineExercise.db_id} = "$id"');
  }

  void removeExercise(int id) async {
    var db = await _getDb();
    await db
        .rawQuery('DELETE FROM $tableNameE WHERE ${Exercise.db_id} = "$id"');
  }

  void removeRoutine(int id) async {
    var db = await _getDb();
    await db.rawQuery('DELETE FROM $tableNameR WHERE ${Routine.db_id} = "$id"');
  }

  void removeExerciseData(int id) async {
    var db = await _getDb();
    await db.rawQuery(
        'DELETE FROM $tableNameED WHERE ${ExerciseData.db_id} = "$id"');
  }

  void removeWorkout(int id) async {
    var db = await _getDb();
    await db.rawQuery('DELETE FROM $tableNameW WHERE ${Workout.db_id} = "$id"');
  }

  void removeUser(int id) async {
    var db = await _getDb();
    await db.rawQuery('DELETE FROM $tableNameU WHERE ${User.db_id} = "$id"');
  }

  void removeStatus(int id) async {
    var db = await _getDb();
    await db.rawQuery('DELETE FROM $tableNameS WHERE ${Status.db_id} = "$id"');
  }
}
