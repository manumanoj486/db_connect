import 'package:postgres/postgres.dart';
import 'package:flutter/material.dart';

class DbConnection with ChangeNotifier {
  String name;
  String host;
  String defaultDB;
  String username;
  String password;
  int port;
  var connection;
  List<List<dynamic>> results1;
  List<Map<String, Map<String, dynamic>>> results;


  DbConnection({this.name, this.host, this.defaultDB, this.username, this.password, this.port});

  Future<void> dbConnection() async {
    connection = new PostgreSQLConnection(host, port, defaultDB, username: username, password: password);
    await connection.open();
  }

  Future<void> executeQuery () async {
    await dbConnection();
    results1 = await connection.query("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'");
    notifyListeners();
    print(results1);

  }

  Future<void> executeWithQuery (String query) async {
    await dbConnection();
    results = await connection.mappedResultsQuery(query);
    //results = await connection.query("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'");
    print(results);


  }

}