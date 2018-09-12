import 'package:meta/meta.dart';

class Routine {
  static final db_name = "name";
  static final db_id = "id";
  static final db_user = "user_id";

  String name;
  int id, user;
  Routine({
    @required this.name,
    @required this.user,
    this.id = null,
  });

  Routine.fromMap(Map<String, dynamic> map)
      : this(
          name: map[db_name],
          id: map[db_id],
          user: map[db_user],
        );

  Map<String, dynamic> toMap() {
    return {
      db_name: name,
      db_id: id,
      db_user: user,
    };
  }
}
