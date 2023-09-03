import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/components/custom_text_widget.dart';
import 'package:todo_hive/utils/constant.dart';
import 'package:todo_hive/view/todo_tile.dart';
import 'package:todo_hive/viewmodels/home_provder.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
      builder: (context, homeProviderValue, child) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          homeProviderValue.getValuesInDB();
        });
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
                    onChanged: (value) =>
                        homeProviderValue.searchFunction(value),
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
                    itemCount: homeProviderValue.tododblist.length,
                    itemBuilder: (context, index) {
                      return TodoTile(
                        onChanged: (value) => homeProviderValue.checkBoxChange(
                            homeProviderValue.tododblist[index]),
                        deleteFunction: () => homeProviderValue.deleteTask(
                            homeProviderValue.tododblist[index].id, context),
                        todomodelitsms: homeProviderValue.tododblist[index],
                      );
                    },
                  )),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => homeProviderValue.createNewTask(context),
            child: Icon(
              Icons.add,
              size: 30,
            ),
          ),
        );
      },
    );
  }
}
