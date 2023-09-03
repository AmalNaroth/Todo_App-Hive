import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_hive/components/custom_text_widget.dart';
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

  List todoList = [
    ["Make tutorail", false],
    ['Do exresice', false],
  ];

  void checkBocChnage(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  void saveNewTask() {
    setState(() {
      todoList.add([titleController.text, false]);
    });
    Navigator.of(context).pop();
  }

  void createNewTask() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditScreen(
              titleController: titleController,
              contentController: contentController,
              onSave: saveNewTask,
              onCancel: () => Navigator.of(context).pop(),
            )));
  }

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {},
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.sort),
                    ),
                  ),
                ],
              ),
              Gap(20),
              TextField(
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
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 30),
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    return TodoTile(
                      onChanged: (value) => checkBocChnage(value, index),
                      taskCompleted: todoList[index][1],
                      taskTitle: todoList[index][0],
                      taskDescripction: "Task need to complete",
                      taskDateAndTime: DateTime.now(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
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
