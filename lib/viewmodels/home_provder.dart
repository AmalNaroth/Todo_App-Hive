import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_hive/components/custom_showdialogebox.dart';
import 'package:todo_hive/models/todo_model.dart';
import 'package:todo_hive/repo/database.dart';
import 'package:todo_hive/view/editing_screen.dart';

class HomeScreenProvider extends ChangeNotifier {
  List<TodoModel> tododblist = [];
  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  List<TodoModel> filteredNotes=[];

  Future<void> getValuesInDB() async {
    try {
      tododblist = await getAllDetails();
      notifyListeners();
    } catch (e) {
      print("Error loading data from the database: $e");
    }
  }

  //crate screen

  void createNewTask(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditScreen(
          titleController: titleController,
          contentController: contentController,
          onSave: () => saveNewTask(context),
          onCancel: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  void checkBoxChange(TodoModel value) {
    value.checkBox = !value.checkBox;
    final updateValue = TodoModel(
        taskTitle: value.taskTitle,
        taskDescipction: value.taskDescipction,
        taskTime: value.taskTime,
        checkBox: value.checkBox,
        id: value.id);
    checkboxUpdate(updateValue);
    getValuesInDB();
    notifyListeners();
  }

  void saveNewTask(BuildContext context) {
    String formattedDate = DateFormat.yMMMd().format(DateTime.now());
    final todomodelvalue = TodoModel(
        taskTitle: titleController.text,
        taskDescipction: contentController.text,
        taskTime: formattedDate,
        checkBox: false);
    addToDataBase(todomodelvalue);
    print("created");
    Navigator.of(context).pop();
    titleController.clear();
    contentController.clear();
    getValuesInDB();
    notifyListeners();
  }

  void deleteTask(int? id, BuildContext context) {
    confirmDialog(context, () {
      deleteItem(id!);
      getValuesInDB();
      notifyListeners();
    });
  }

  void searchFunction(String searchKey) {
    filteredNotes.clear();
    filteredNotes = tododblist
        .where((element) =>
            element.taskTitle.toLowerCase().contains(searchKey.toLowerCase()) ||
            element.taskDescipction
                .toLowerCase()
                .contains(searchKey.toLowerCase()))
        .toList();
  }
}
