import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_hive/models/todo_model.dart';
import 'package:todo_hive/utils/constant.dart';

Random random = Random();

class TodoTile extends StatelessWidget {
  Function(bool?)? onChanged;
  Function deleteFunction;
  TodoModel todomodelitsms;
  TodoTile(
      {super.key,
      required this.onChanged,
      required this.deleteFunction,
      required this.todomodelitsms});

  String formattedDate = DateFormat.yMMMd().format(DateTime.now());

  getRadomColors() {
    return colosList[random.nextInt(colosList.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      //color: getRadomColors(),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CheckboxListTile(
          activeColor: Colors.black,
          value: todomodelitsms.checkBox,
          onChanged: onChanged,
          title: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: "${todomodelitsms.taskTitle}\n",
              style: TextStyle(
                decoration: todomodelitsms.checkBox
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: "${todomodelitsms.taskDescipction}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Edited: ${todomodelitsms.taskTime}',
              style: TextStyle(
                fontSize: 10,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          controlAffinity: ListTileControlAffinity
              .leading, // To place the checkbox on the left side
          secondary: IconButton(
            onPressed: () {
              deleteFunction();
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ),
      ),
    );
  }
}
