import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/customerModel.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'customers';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'your_database_name.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fullName TEXT,
            mobileNumber TEXT,
            emailId TEXT,
            latitude TEXT,
            longitude TEXT,
            address TEXT,
            imageUrl TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertCustomer(Map<String, dynamic> customerData) async {
    Customer customer = Customer(
      fullName: customerData['fullName'],
      mobileNumber: customerData['mobileNumber'],
      emailId: customerData['emailId'],
      latitude: customerData['latitude'],
      longitude: customerData['longitude'],
      address: customerData['address'],
      imageUrl: customerData['imageUrl'],
    );

    Database db = await database;
    await db.insert(tableName, customer.toMap());
  }

  Future<List<Customer>> getAllCustomers() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (index) {
      return Customer.fromMap(maps[index]);
    });
  }
}
