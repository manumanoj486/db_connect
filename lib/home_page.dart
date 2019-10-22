import 'package:flutter/material.dart';
import 'package:db_connection_poc/utils/db_connection.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title,this.dbConnection}) : super(key: key);
  var connection;
  final String title;
  final DbConnection dbConnection;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupConnection();

  }
  void setupConnection() async {
    await widget.dbConnection.executeQuery();
//    List li = connection.results1;
  }

  @override
  Widget build(BuildContext context) {

//    if(connection.results1 == null){
//    }
    return Scaffold(
        body: widget.dbConnection.results1 != null
            ? ListView(
          padding: EdgeInsets.all(8.0),
          children: widget.dbConnection.results1
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
