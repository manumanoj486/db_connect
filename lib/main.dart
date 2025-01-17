import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'home_page.dart';
import 'execution_query.dart';
import 'result.dart';
import 'datatable.dart';
import 'package:db_connection_poc/utils/db_connection.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<DbConnection>(
        builder: (_) => DbConnection(
          name: 'dbb',
          host: '192.168.68.127',
          port: 5432,
          defaultDB: 'reckon_dev',
          username: 'postgres',
          password: 'francium',
          currenyQuery: ''
           ),
        child: MyMaterialApp());

  }



}

class MyMaterialApp extends StatefulWidget {
  @override
  _MyMaterialAppState createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {

  int _currentIndex = 0;



  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final connection  = Provider.of<DbConnection>(context);

    final List<Widget> _children = [
      MyHomePage(dbConnection: connection),
      QueryExecution(onTabTapped),
      connection.results == null ? Center(child: CircularProgressIndicator(),)  :ResultTable(connection.results)
    ];

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tabs Demo'),
          ),
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped, // new
            currentIndex: _currentIndex, // new
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.table_chart),
                title: Text('Tables'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.query_builder),
                title: Text('Quary'),
              ),
              new BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_turned_in),
                  title: Text('Results')
              )
            ],
          ),),
      ),
    );
  }
}

