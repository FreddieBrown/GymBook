import 'package:meta/meta.dart';

class Exercise {
  static final db_name = "name";
  static final db_notes = "notes";
  static final db_id = "id";
  static final db_flag = "flag";
  static final db_user = "user";

  String name, notes;
  int id, flag, user;
  Exercise({
    @required this.name,
    this.id = null,
    this.flag = 0,
    this.notes = "",
    this.user = 0,
  });

  Exercise.fromMap(Map<String, dynamic> map)
      : this(
          name: map[db_name],
          notes: map[db_notes],
          id: map[db_id],
          flag: map[db_flag],
          user: map[db_user],
        );

  Map<String, dynamic> toMap() {
    return {
      db_name: name,
      db_notes: notes,
      db_id: id,
      db_flag: flag,
      db_user: user,
    };
  }
}
