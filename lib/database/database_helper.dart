import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseHelper {
  static Database? _database;

  // ============================================================
  // DATABASE INSTANCE
  // ============================================================

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  // ============================================================
  // INITIALIZE DATABASE
  // ============================================================

  static Future<Database> _initDatabase() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }

    final db = await openDatabase(
      'energy_saver.db',
      version: 1,
      onCreate: (Database db, int version) async {
        // ======================================================
        // USERS
        // ======================================================

        await db.execute('''
          CREATE TABLE users (
            user_id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL,
            created_at TEXT DEFAULT CURRENT_TIMESTAMP
          )
        ''');

        // ======================================================
        // DEVICES
        // ======================================================

        await db.execute('''
          CREATE TABLE devices (
            device_id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            device_name TEXT NOT NULL,
            room TEXT,
            device_type TEXT,
            power_watts REAL DEFAULT 0,
            is_on INTEGER DEFAULT 0,
            minutes_used_today INTEGER DEFAULT 0,
            created_at TEXT DEFAULT CURRENT_TIMESTAMP
          )
        ''');

        // ======================================================
        // REMINDERS
        // ======================================================

        await db.execute('''
          CREATE TABLE reminders (
            reminder_id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            title TEXT NOT NULL,
            reminder_time TEXT,
            is_active INTEGER DEFAULT 1,
            completed INTEGER DEFAULT 0,
            created_at TEXT DEFAULT CURRENT_TIMESTAMP
          )
        ''');

        // ======================================================
        // ENERGY USAGE
        // ======================================================

        await db.execute('''
          CREATE TABLE energy_usage (
            usage_id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            usage_date TEXT NOT NULL,
            energy_used_kwh REAL DEFAULT 0,
            energy_saved_kwh REAL DEFAULT 0,
            money_saved REAL DEFAULT 0,
            co2_reduced REAL DEFAULT 0
          )
        ''');

        // ======================================================
        // ACHIEVEMENTS
        // ======================================================

        await db.execute('''
          CREATE TABLE achievements (
            achievement_id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            achievement_name TEXT NOT NULL,
            description TEXT,
            is_unlocked INTEGER DEFAULT 0,
            unlocked_at TEXT
          )
        ''');
      },
    );

    return db;
  }

  // ============================================================
  // USER FUNCTIONS
  // ============================================================

  static Future<int> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final db = await database;

    return await db.insert('users', {
      'name': name.trim(),
      'email': email.trim().toLowerCase(),
      'password': password.trim(),
    }, conflictAlgorithm: ConflictAlgorithm.abort);
  }

  static Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  }) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'LOWER(email) = ?',
      whereArgs: [email.trim().toLowerCase()],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    final user = result.first;
    if (user['password'] != password.trim()) {
      return null;
    }

    return user;
  }

  static Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  // ============================================================
  // DEVICE FUNCTIONS
  // ============================================================

  static Future<int> addDevice({
    required int userId,
    required String name,
    required String room,
    required String type,
    required double power,
    bool isOn = false,
    int minutesUsedToday = 0,
  }) async {
    final db = await database;

    return await db.insert('devices', {
      'user_id': userId,
      'device_name': name,
      'room': room,
      'device_type': type,
      'power_watts': power,
      'is_on': isOn ? 1 : 0,
      'minutes_used_today': minutesUsedToday,
    });
  }

  static Future<List<Map<String, dynamic>>> getDevices(int userId) async {
    final db = await database;

    return await db.query(
      'devices',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'device_id ASC',
    );
  }

  static Future<int> updateDevice({
    required int deviceId,
    required bool isOn,
    required int minutesUsedToday,
  }) async {
    final db = await database;

    return await db.update(
      'devices',
      {'is_on': isOn ? 1 : 0, 'minutes_used_today': minutesUsedToday},
      where: 'device_id = ?',
      whereArgs: [deviceId],
    );
  }

  static Future<int> deleteDevice(int deviceId) async {
    final db = await database;

    return await db.delete(
      'devices',
      where: 'device_id = ?',
      whereArgs: [deviceId],
    );
  }

  // ============================================================
  // REMINDER FUNCTIONS
  // ============================================================

  static Future<int> addReminder({
    required int userId,
    required String title,
    required String time,
    bool isActive = true,
    bool completed = false,
  }) async {
    final db = await database;

    return await db.insert('reminders', {
      'user_id': userId,
      'title': title,
      'reminder_time': time,
      'is_active': isActive ? 1 : 0,
      'completed': completed ? 1 : 0,
    });
  }

  static Future<List<Map<String, dynamic>>> getReminders(int userId) async {
    final db = await database;

    return await db.query(
      'reminders',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'reminder_id ASC',
    );
  }

  static Future<int> updateReminder({
    required int reminderId,
    required bool completed,
    required bool isActive,
  }) async {
    final db = await database;

    return await db.update(
      'reminders',
      {'completed': completed ? 1 : 0, 'is_active': isActive ? 1 : 0},
      where: 'reminder_id = ?',
      whereArgs: [reminderId],
    );
  }

  static Future<int> deleteReminder(int reminderId) async {
    final db = await database;

    return await db.delete(
      'reminders',
      where: 'reminder_id = ?',
      whereArgs: [reminderId],
    );
  }

  // ============================================================
  // ENERGY USAGE FUNCTIONS
  // ============================================================

  static Future<int> addEnergyUsage({
    required int userId,
    required String date,
    required double energyUsed,
    required double energySaved,
    required double moneySaved,
    required double co2Reduced,
  }) async {
    final db = await database;

    return await db.insert('energy_usage', {
      'user_id': userId,
      'usage_date': date,
      'energy_used_kwh': energyUsed,
      'energy_saved_kwh': energySaved,
      'money_saved': moneySaved,
      'co2_reduced': co2Reduced,
    });
  }

  static Future<List<Map<String, dynamic>>> getEnergyUsage(int userId) async {
    final db = await database;

    return await db.query(
      'energy_usage',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'usage_id ASC',
    );
  }

  // ============================================================
  // ACHIEVEMENT FUNCTIONS
  // ============================================================

  static Future<int> addAchievement({
    required int userId,
    required String name,
    required String description,
    bool unlocked = false,
  }) async {
    final db = await database;

    return await db.insert('achievements', {
      'user_id': userId,
      'achievement_name': name,
      'description': description,
      'is_unlocked': unlocked ? 1 : 0,
      'unlocked_at': unlocked ? DateTime.now().toIso8601String() : null,
    });
  }

  static Future<List<Map<String, dynamic>>> getAchievements(int userId) async {
    final db = await database;

    return await db.query(
      'achievements',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'achievement_id ASC',
    );
  }

  static Future<int> updateAchievement({
    required int achievementId,
    required bool unlocked,
  }) async {
    final db = await database;

    return await db.update(
      'achievements',
      {
        'is_unlocked': unlocked ? 1 : 0,
        'unlocked_at': unlocked ? DateTime.now().toIso8601String() : null,
      },
      where: 'achievement_id = ?',
      whereArgs: [achievementId],
    );
  }

  // ============================================================
  // DATABASE TEST
  // ============================================================

  static Future<List<Map<String, dynamic>>> getAllTables() async {
    final db = await database;

    return await db.rawQuery(
      "SELECT name FROM sqlite_master "
      "WHERE type='table' "
      "ORDER BY name",
    );
  }
}
