import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class ToDo extends HiveObject {
  @HiveField(0)
  late String task;
  @HiveField(1)
  late String date;
  @HiveField(2)
  late int priority;
  @HiveField(3)
  late String status;
}
