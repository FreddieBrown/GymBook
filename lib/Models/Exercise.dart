import 'package:meta/meta.dart';

class Exercise {
  static final db_name = "name";
  static final db_notes = "notes";
  static final db_id = "id";

  String name, notes;
  int id;
  Exercise({
    @required this.name,
    this.id = null,
    this.notes = "",
  });

  Exercise.fromMap(Map<String, dynamic> map): this(
    name: map[db_name],
    notes: map[db_notes],
    id: map[db_id],
  );

  // Currently not used
  Map<String, dynamic> toMap() {
    return {
      db_name: name,
      db_notes: notes,
      db_id: id,
    };
  }
}