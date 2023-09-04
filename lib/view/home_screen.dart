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
    //log("Reload");
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Consumer<HomeScreenProvider>(
      builder: (context, homeProviderValue, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          homeProviderValue.getValuesInDB();
        });
        return Scaffold(
          backgroundColor: scaffoldBg,
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
                        width: screenWidth * .25 / 2,
                        height: screenWidth * .25 / 2,
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
                        contentPadding: EdgeInsets.symmetric(
                            vertical: screenWidth * .1 / 2),
                        hintText: "Search ToDo",
                        prefixIcon: Icon(Icons.search),
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: searchBorder,
                        focusedBorder: searchBorder),
                  ),
                  Expanded(
                    child: homeProviderValue.filteredNotesGet.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.only(top: 30),
                            itemCount:
                                homeProviderValue.filteredNotesGet.length,
                            itemBuilder: (context, index) {
                              return TodoTile(
                                onChanged: (value) => homeProviderValue
                                    .checkBoxChange(homeProviderValue
                                        .filteredNotesGet[index]),
                                deleteFunction: () =>
                                    homeProviderValue.deleteTask(
                                        homeProviderValue
                                            .filteredNotesGet[index].id,
                                        context),
                                todomodelitsms:
                                    homeProviderValue.filteredNotesGet[index],
                              );
                            },
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(top: 30),
                            itemCount: homeProviderValue.tododblistGet.length,
                            itemBuilder: (context, index) {
                              return TodoTile(
                                onChanged: (value) =>
                                    homeProviderValue.checkBoxChange(
                                        homeProviderValue.tododblistGet[index]),
                                deleteFunction: () =>
                                    homeProviderValue.deleteTask(
                                        homeProviderValue
                                            .tododblistGet[index].id,
                                        context),
                                todomodelitsms:
                                    homeProviderValue.tododblistGet[index],
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => homeProviderValue.createNewTask(context),
            child: Icon(
              Icons.add,
              color: whiteColor,
              size: screenWidth * .15 / 2,
            ),
          ),
        );
      },
    );
  }
}
