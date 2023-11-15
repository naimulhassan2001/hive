

import 'package:flutter_hive/models/note_model.dart';
import 'package:hive/hive.dart';

class Boxes  {
  static Box<NotesModel> getData()  => Hive.box('Naimul') ;
}