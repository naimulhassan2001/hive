

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
           var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(

                        children: [
                          Text(data[index].title.toString(), style: TextStyle(fontSize: 18),),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              _update(data[index] , data[index].title.toString(), data[index].description.toString()) ;
                            },
                              child: Icon(Icons.edit)),
                          SizedBox(width: 15,) ,
                          InkWell(
                            onTap: () {
                              delete(data[index]) ;
                            },
                              child: Icon(Icons.delete)),
                        ],
                      ),
                      Text(data[index].description.toString()),
                    ],
                  ),


                ),
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
                        labelText: 'Title',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        labelText: 'Description',
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


  Future<void> _update(NotesModel notesModel, String title, String description) async{


    titleController.text = title ;
    descriptionController.text = description ;

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
                        labelText: 'Title',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
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

                notesModel.title = titleController.text ;
                notesModel.description = descriptionController.text ;


                notesModel.save() ;


                titleController.clear();
                descriptionController.clear();



                Navigator.pop(context) ;
              },
                  child: Text('Update')),
            ],
          );
        },) ;




  }




  Future<void> delete (NotesModel notesModel) async {
    notesModel.delete() ;
  }





}
