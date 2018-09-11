import 'database/db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'Models/User.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Auth{

  static newUser(String email, String name, String salt, String pass) async{
    var u = await db.get().getUserByEmail(email);
    if(u == null){
      var utfSalt = utf8.encode(salt);
      var digestSalt = sha256.convert(utfSalt);
      var utfPass = utf8.encode("$pass+${digestSalt.toString()}");
      var digestPass = sha256.convert(utfPass);
      await db.get().updateUser(User(salt: digestSalt.toString(), name: name, hashp: digestPass.toString(), email: email));
      if(await db.get().getUserByEmail(email) != null){
        return 1;
      }
      else{
        return -1;
      }
    }
    else{
      return 0;
    }
  }

  static checkUser(String email, String pass) async{

  }

  static loginUser(String email, String pass) async{

  }

  static logoutUser(int id) async{

  }
}