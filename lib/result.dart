import 'package:flutter/material.dart';
import 'package:db_connection_poc/utils/db_connection.dart';
import 'package:provider/provider.dart';


class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {


  @override
  Widget build(BuildContext context) {
    final connection  = Provider.of<DbConnection>(context);
    setState(() {
      connection.results;
    });
    return Scaffold(
     body: Container(
       alignment: Alignment.center,
       child: connection.results == null ? CircularProgressIndicator() : Text(connection.results.toString())
     ),);
  }
}
