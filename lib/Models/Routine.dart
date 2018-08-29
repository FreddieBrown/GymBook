import 'package:meta/meta.dart';

class Routine {
  static final db_name = "name";
  static final db_id = "id";

  String name;
  int id;
  Routine({
    @required this.name,
    this.id = null,
  });

  Routine.fromMap(Map<String, dynamic> map): this(
    name: map[db_name],
    id: map[db_id],
  );

  // Currently not used
  Map<String, dynamic> toMap() {
    return {
      db_name: name,
      db_id: id,
    };
  }
}