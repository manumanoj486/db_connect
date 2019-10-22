import 'package:flutter/material.dart';
import 'result.dart';

class QueryExecution extends StatelessWidget {
  String field;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: TextField(
          controller: controller,
          style: TextStyle(fontSize: 20.0),
          decoration: InputDecoration.collapsed(hintText: 'Enter query to run'),
          autofocus: true,
          maxLines: null,
          onChanged: (text) {
            field = text;
          },

        ),
      ),
     floatingActionButton:FloatingActionButton(
       onPressed: () {
         print(controller.text);
         Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => Result()));
       },
       child: Icon(Icons.send),
       backgroundColor: Colors.green,
     ) ,
    );
  }
}
