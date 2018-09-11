import 'database/db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/User.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Auth{

  static newUser(String email, String name, String salt, String pass) async{
    if(!(await isUser(email))){
      var utfSalt = utf8.encode(salt);
      var digestSalt = sha256.convert(utfSalt);
      var utfPass = utf8.encode("$pass+${digestSalt.toString()}");
      var digestPass = sha256.convert(utfPass);
      await db.get().updateUser(User(salt: digestSalt.toString(), name: name, hashp: digestPass.toString(), email: email.toLowerCase()));
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

  static isUser(String email) async{
    var u = await db.get().getUserByEmail(email.toLowerCase());
    if(u == null){
      return false;
    }
    return true;
  }

  static checkUser(String email, String pass) async{
    if((await isUser(email))){
      var u = await db.get().getUserByEmail(email.toLowerCase());
      var utfPass = utf8.encode("$pass+${u.salt}");
      var digestPass = sha256.convert(utfPass);
      if(u.hashp == digestPass.toString()){
        return u;
      }
    }
    return null;
  }

  static loginUser(String email, String pass) async{
    final prefs = await SharedPreferences.getInstance();
    var u = await checkUser(email, pass);
    if(u != null){
      prefs.setInt('id', u.id);
      prefs.setString('name', u.name);
      prefs.setString('email', u.email.toLowerCase());
      prefs.setInt('dev', u.dev);
      return true;
    }
    return false;
  }

  static logoutUser() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('dev');
    return true;
  }
}