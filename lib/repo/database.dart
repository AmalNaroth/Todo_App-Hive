import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/models/todo_model.dart';

ValueNotifier<List<TodoModel>> todoListNotifier = ValueNotifier([]);

void addToDataBase(TodoModel value) async {
  try {
    final _tododb = await Hive.openBox<TodoModel>('todobox_db');
    final _id = await _tododb.add(value);
    final newValue = TodoModel(
      taskTitle: value.taskTitle,
      taskDescipction: value.taskDescipction, // Correct the property name
      taskTime: value.taskTime,
      checkBox: value.checkBox,
      id: _id,
    );
    await _tododb.put(_id, newValue);
    getAllDetails();
    print("Added to database");
  } catch (e) {
    print("Error adding to database: $e");
  }
}

void getAllDetails() async {
  try {
    final _tododb = await Hive.openBox<TodoModel>('todobox_db');
    todoListNotifier.value.clear();
    todoListNotifier.value.addAll(_tododb.values);
    todoListNotifier.notifyListeners();
  } catch (e) {
    print("Error retrieving data from database: $e");
  }
}


void deleteItem(int id) async {
  final _todo = await Hive.openBox<TodoModel>("todobox_db");
  await _todo.delete(id);
  getAllDetails();
}

void checkboxUpdate(TodoModel value) async{
  final _todo = await Hive.openBox<TodoModel>("todobox_db");
  await _todo.putAt(value.id!, value);
  getAllDetails();
}
