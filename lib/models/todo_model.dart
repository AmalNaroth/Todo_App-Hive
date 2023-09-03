// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'todo_model.g.dart';
@HiveType(typeId: 1)
class TodoModel extends HiveObject{
  @HiveField(0)
  int? id;
  @HiveField(1)
  String taskTitle;
  @HiveField(2)
  String taskDescipction;
  @HiveField(3)
  String taskTime;
  @HiveField(4)
  bool checkBox;
  TodoModel({
    required this.taskTitle,
    required this.taskDescipction,
    required this.taskTime,
    required this.checkBox,
    this.id
  });
}
