import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_hive/utils/constant.dart';

Random random = Random();

class TodoTile extends StatelessWidget {
  final String taskTitle;
  final String taskDescripction;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  DateTime taskDateAndTime;
  TodoTile(
      {super.key,
      required this.taskTitle,
      required this.taskDescripction,
      required this.taskCompleted,
      required this.onChanged,
      required this.taskDateAndTime});

      String formattedDate = DateFormat.yMMMd().format(DateTime.now());

  getRadomColors() {
    return colosList[random.nextInt(colosList.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      color: getRadomColors(),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CheckboxListTile(
          activeColor: Colors.black,
          value: taskCompleted,
          onChanged: onChanged,
          title: RichText(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: "$taskTitle\n",
              style:  TextStyle(
                decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: taskDescripction,
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
              'Edited: $formattedDate',
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
              // confirmDialog(context);
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
