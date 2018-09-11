import 'package:meta/meta.dart';

class Status {
  static final db_id = "id";

  int id;

  Status({
    @required this.id,
  });

  Status.fromMap(Map<String, dynamic> map): this(
    id: map[db_id],
  );

  Map<String, dynamic> toMap() {
    return {
      db_id: id,
    };
  }
}