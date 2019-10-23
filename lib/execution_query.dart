import 'package:flutter/material.dart';
import 'package:db_connection_poc/utils/db_connection.dart';
import 'package:provider/provider.dart';
import 'result.dart';

class QueryExecution extends StatelessWidget {
  String field;

  QueryExecution(this.change_tab);
  final Function change_tab;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final connection  = Provider.of<DbConnection>(context);
    if(connection.currenyQuery!=""){
      controller.text = connection.currenyQuery;
    }

    return Scaffold(
      body:Container(
        child: TextField(
          controller: controller,
          style: TextStyle(fontSize: 20.0),
          decoration: InputDecoration.collapsed(hintText: 'Enter the query here'),
          autofocus: true,
          maxLines: null,
          onChanged: (text) {
            field = text;
          },
        ),
      ),
     floatingActionButton:FloatingActionButton(
       onPressed: () {
         connection.results = null;
         CircularProgressIndicator();
         connection.currenyQuery = controller.text;
         connection.executeWithQuery(controller.text);
         change_tab(2);
       },
       child: Icon(Icons.send),
       backgroundColor: Colors.green,
     ) ,
    );
  }
}
