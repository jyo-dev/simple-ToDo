import 'package:hive/hive.dart';
import 'package:techrtwo/model/todo_model.dart';

class Boxes {
  static Box<ToDo> getTasks() =>
      Hive.box<ToDo>('tasks');
}