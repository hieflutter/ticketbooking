import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ticketbooking/Model/usermodel.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'Busbooking.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY,
        Username TEXT,
        EmailId TEXT,
        MobileNo Integer,
        password TEXT
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> userdata) async {
    Database db = await instance.database;
    int userId = await db.insert('user', userdata);
    return userId;
  }

  Future<UserModel?> getUser(String email, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(
      'user',
      where: 'EmailId = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (results.isNotEmpty) {
      return UserModel.fromJson(results.first);
    }
    return null;
  }
  //  Future<void> storeUserSession(UserModel user) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   // Store user data in SharedPreferences
  //   await prefs.setString('userId', user.id.toString());
  //   await prefs.setString('username', user.username??"");
  //   await prefs.setString('email', user.email??"");
  //   await prefs.setInt('mobile', user.mobileNo!);
  // }

  // // Function to clear user session from SharedPreferences
  // Future<void> clearUserSession() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   // Remove user data from SharedPreferences
  //   await prefs.remove('userId');
  //   await prefs.remove('username');
  //   await prefs.remove('email');
  //   await prefs.remove('mobile');
  // }
}

