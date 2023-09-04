import 'package:flutter/material.dart';

class EditScreen extends StatelessWidget {
  TextEditingController? titleController;
  TextEditingController? contentController;
  VoidCallback? onSave;
  VoidCallback? onCancel;
  EditScreen(
      {super.key,
      this.titleController,
      this.contentController,
      this.onSave,
      this.onCancel});

  @override
  Widget build(BuildContext context) {
    final screenWidth =  MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: onCancel,
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    width: screenWidth*.25/2,
                    height: screenWidth*.25/2,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800.withOpacity(.8),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
          Expanded(
              child: ListView(
            children: [
              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.black, fontSize: 30),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 30)),
              ),
              Divider(
                thickness: 3,
              ),
              TextField(
                controller: contentController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                maxLines: 10,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type something here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
            ],
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onSave,
        elevation: screenWidth*15/2,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.done_all_outlined,color: Colors.white,),
      ),
    );
  }
}
