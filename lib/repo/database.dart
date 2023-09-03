import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/models/todo_model.dart';

void addToDataBase(TodoModel value) async {
  try {
    final _tododb = await Hive.openBox<TodoModel>('todobox_db');
    final _id = await _tododb.add(value);
    final newValue = TodoModel(
      taskTitle: value.taskTitle,
      taskDescipction: value.taskDescipction,
      taskTime: value.taskTime,
      checkBox: value.checkBox,
      id: _id,
    );
    await _tododb.put(_id, newValue);
    await getAllDetails();
    print("Added to database");
  } catch (e) {
    print("Error adding to database: $e");
  }
}

Future<List<TodoModel>> getAllDetails() async {
  try {
    final _tododb = await Hive.openBox<TodoModel>('todobox_db');
    final todoList = _tododb.values.toList();
    return todoList;
  } catch (e) {
    print("Error retrieving data from database: $e");
    return [];
  }
}

Future<void> deleteItem(int id) async {
  final _tododb = await Hive.openBox<TodoModel>("todobox_db");
  try {
    await _tododb.delete(id);
    await getAllDetails();
  } catch (e) {
    print("Error deleting item from database: $e");
  } finally {
    _tododb.close();
  }
}

Future<void> checkboxUpdate(TodoModel value) async {
  try {
    final _tododb = await Hive.openBox<TodoModel>("todobox_db");
    await _tododb.putAt(value.id!, value);
    getAllDetails();
  } catch (err) {
    print("Error from database: $err");
  }
}
