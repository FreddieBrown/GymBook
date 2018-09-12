import 'package:meta/meta.dart';

class User {
  static final db_id = "id";
  static final db_name = "name";
  static final db_email = "email";
  static final db_salt = "salt";
  static final db_hashp = "hashp";
  static final db_dev = "dev";

  int id, dev;
  String name, salt, hashp, email;

  User({
    this.id = null,
    @required this.salt,
    @required this.name,
    @required this.hashp,
    @required this.email,
    this.dev = 0,
  });

  User.fromMap(Map<String, dynamic> map)
      : this(
          id: map[db_id],
          name: map[db_name],
          email: map[db_email],
          salt: map[db_salt],
          hashp: map[db_hashp],
          dev: map[db_dev],
        );

  Map<String, dynamic> toMap() {
    return {
      db_id: id,
      db_name: name,
      db_email: email,
      db_salt: salt,
      db_hashp: hashp,
      db_dev: dev
    };
  }
}
