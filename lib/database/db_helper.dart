import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE leads(id INTEGER PRIMARY KEY, name TEXT)');
        await db.execute('CREATE TABLE clients(id INTEGER PRIMARY KEY, name TEXT, email TEXT)');
        await db.execute('CREATE TABLE properties(id INTEGER PRIMARY KEY, address TEXT, price REAL)');
        await db.execute('CREATE TABLE deals(id INTEGER PRIMARY KEY, clientId INTEGER, propertyId INTEGER, date TEXT)');
        await db.execute('CREATE TABLE followups(id INTEGER PRIMARY KEY, dealId INTEGER, date TEXT)');
        await db.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, completed INTEGER)');
      },
    );
  }

  // Methods for Leads
  Future<int> insertLead(Map<String, dynamic> lead) async {
    final db = await database;
    return await db.insert('leads', lead);
  }

  // Methods for Clients
  Future<int> insertClient(Map<String, dynamic> client) async {
    final db = await database;
    return await db.insert('clients', client);
  }

  // Methods for Properties
  Future<int> insertProperty(Map<String, dynamic> property) async {
    final db = await database;
    return await db.insert('properties', property);
  }

  // Methods for Deals
  Future<int> insertDeal(Map<String, dynamic> deal) async {
    final db = await database;
    return await db.insert('deals', deal);
  }

  // Methods for Follow-ups
  Future<int> insertFollowup(Map<String, dynamic> followup) async {
    final db = await database;
    return await db.insert('followups', followup);
  }

  // Methods for Tasks
  Future<int> insertTask(Map<String, dynamic> task) async {
    final db = await database;
    return await db.insert('tasks', task);
  }
}