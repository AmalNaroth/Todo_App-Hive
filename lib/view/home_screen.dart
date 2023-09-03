import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_hive/components/custom_text_widget.dart';
import 'package:todo_hive/models/todo_model.dart';
import 'package:todo_hive/repo/database.dart';
import 'package:todo_hive/utils/constant.dart';
import 'package:todo_hive/view/editing_screen.dart';
import 'package:todo_hive/view/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  List<TodoModel> filteredNotes = [];

  void checkBoxChange(TodoModel value) {
    value.checkBox = !value.checkBox;
    final updateValue = TodoModel(
        taskTitle: value.taskTitle,
        taskDescipction: value.taskDescipction,
        taskTime: value.taskTime,
        checkBox: value.checkBox);
    checkboxUpdate(value);
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
  }

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

  void deleteTask(int? id) {
    deleteItem(id!);
  }

  void searchFunction(String searchKey) {
    filteredNotes.clear();
    setState(() {
      filteredNotes = todoListNotifier.value
        .where((element) =>
            element.taskTitle.toLowerCase().contains(searchKey.toLowerCase()) ||
            element.taskDescipction
                .toLowerCase()
                .contains(searchKey.toLowerCase()))
        .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllDetails();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget("MY TODO",
                      fontSize: 25, fontWeight: FontWeight.bold),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300),
                    child: IconButton(
                      onPressed: () {
                        getAllDetails();
                      },
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.sort),
                    ),
                  ),
                ],
              ),
              Gap(20),
              TextField(
                onChanged: (value) => searchFunction(value),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    hintText: "Search ToDo",
                    prefixIcon: Icon(Icons.search),
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    border: searchBorder,
                    focusedBorder: searchBorder),
              ),
              Expanded(
                child: filteredNotes.isNotEmpty
                    ? ListView.builder(
                      itemCount: filteredNotes.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(filteredNotes[index].taskTitle),
                        ),
                      )
                    : ValueListenableBuilder(
                        valueListenable: todoListNotifier,
                        builder: (context, todolistitems, child) {
                          return ListView.builder(
                            padding: EdgeInsets.only(top: 30),
                            itemCount: todolistitems.length,
                            itemBuilder: (context, index) {
                              return TodoTile(
                                onChanged: (value) =>
                                    checkBoxChange(todolistitems[index]),
                                deleteFunction: () =>
                                    deleteTask(todolistitems[index].id),
                                todomodelitsms: todolistitems[index],
                              );
                            },
                          );
                        }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewTask(context),
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            icon: const Icon(
              Icons.info,
              color: Colors.grey,
            ),
            title: const Text(
              'Are you sure you want to delete?',
              style: TextStyle(color: Colors.white),
            ),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'Yes',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'No',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ]),
          );
        });
  }
}
