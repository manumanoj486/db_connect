import 'package:flutter/material.dart';
import 'package:db_connection_poc/utils/db_connection.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.dbConnection}) : super(key: key);
  var connection;
  final String title;
  final DbConnection dbConnection;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    // if failed,use refreshFailed()
     setupConnection();
     await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }

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
            ? SmartRefresher(
                enablePullDown: true,
                controller: _refreshController,
                header: WaterDropHeader(),
                onRefresh: _onRefresh,
                child: ListView(
                  padding: EdgeInsets.all(8.0),
                  children: widget.dbConnection.results1
                      .map((data) => ListTile(
                            leading: Icon(Icons.border_horizontal),
                            title: Text(data[0]),
                            subtitle: Text("Db Table"),
                          ))
                      .toList(),
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
