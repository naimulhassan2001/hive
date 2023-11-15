

import 'package:flutter/material.dart';
import 'package:flutter_hive/models/note_model.dart';
import 'package:hive/hive.dart';
import 'package:flutter_hive/boxes/boxes.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController titleController = TextEditingController() ;
  TextEditingController descriptionController = TextEditingController() ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Hive'),
      ),
      body:  ValueListenableBuilder(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, child) {
           List<dynamic> data = box.values.toList();
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              return ListTile(
                 title: Text(data[index].title.toString()),
                 subtitle: Text(data[index].description.toString()),

              ) ;
            },);
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async{

           _showDialog() ;

          },
        child:  Icon(Icons.add),
      ),
    );
  }

  Future<void> _showDialog() async{

    return showDialog(
        context: context,
        builder: (context) {

          return AlertDialog(
            title:  Text('Add Notes'),
            content:  SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(context) ;
              },
                  child: const Text('Canecl')),
              TextButton(onPressed: () {

                final data = NotesModel(title: titleController.text,
                    description: descriptionController.text) ;

                final box = Boxes.getData() ;
                box.add(data) ;
                titleController.clear();
                descriptionController.clear();



                Navigator.pop(context) ;
              },
                  child: Text('Add')),
            ],
          );
        },) ;




  }





}
