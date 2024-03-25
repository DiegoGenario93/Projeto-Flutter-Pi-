import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Importe o pacote sqflite_ffi
import 'models.dart';
import 'dart:typed_data';
import 'dart:async';


import 'models.dart';
import 'dart:typed_data';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  late Database _db;

  DatabaseHelper._internal() {
    // Inicialize a fábrica de banco de dados
    sqfliteFfiInit();
    // Defina a fábrica de banco de dados como sqflite ffi
    databaseFactory = databaseFactoryFfi;
  }

  Future<Database> get db async {
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String path = "main.db";
    print("Caminho do banco de dados: $path");

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    print("Banco de dados criado com sucesso");
    return ourDb;
  }

  static void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE MaintenanceForms(id INTEGER PRIMARY KEY, description TEXT, name TEXT, email TEXT, image BLOB)");
    print("Tabela criada");
  }

  Future<int> saveForm(MaintenanceForm form) async {
    var dbClient = await db;
    int res = await dbClient.insert("MaintenanceForms", form.toMap());
    print("Formulário salvo no banco de dados: $form");
    return res;
  }

  Future<List<MaintenanceForm>> getForms() async {
    var dbClient = await db;
    List<Map> list = await dbClient.query("MaintenanceForms");
    List<MaintenanceForm> forms = [];
    for (int i = 0; i < list.length; i++) {
      var id = list[i]['id'];
      var imageBytes = list[i]['image'] as Uint8List?;
      forms.add(MaintenanceForm(
        id: id != null ? id : 0,
        description: list[i]['description'],
        name: list[i]['name'],
        email: list[i]['email'],
        image: imageBytes,
      ));
    }
    print("Formulários recuperados do banco de dados: $forms");
    return forms;
  }
}




