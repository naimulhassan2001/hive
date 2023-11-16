import 'package:flutter/material.dart';
import 'package:flutter_hive/models/note_model.dart';
import 'package:flutter_hive/pages/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationCacheDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('naimul') ;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}


