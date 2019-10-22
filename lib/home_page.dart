import 'package:flutter/material.dart';
import 'package:db_connection_poc/utils/db_connection.dart';
import 'package:provider/provider.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  var connection;
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void setupConnection() async {
    final connection = Provider.of<DbConnection>(context);
    await connection.executeQuery();
//    List li = connection.results1;
    setState(() {
      if (connection.results1.isNotEmpty) {
        print(connection.results1.length);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setupConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: connection.results1 != null
            ? ListView(
          padding: EdgeInsets.all(8.0),
          children: connection.results1
              .map((data) => ListTile(
            leading: Icon(Icons.border_horizontal),
            title: Text(data[0]),
            subtitle: Text("Db Table"),
          ))
              .toList(),
        )
            : Center(
            child:CircularProgressIndicator() ));
  }

}
