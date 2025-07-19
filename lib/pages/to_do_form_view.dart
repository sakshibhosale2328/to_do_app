import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../model/todo_model.dart';

class TodoFormView extends StatelessWidget {
  final Todo? todo;
  final _title = TextEditingController();
  final _desc = TextEditingController();
  final HomeController c = Get.find();

  TodoFormView({Key? key, this.todo}) : super(key: key) {
    if (todo != null) {
      _title.text = todo!.title;
      _desc.text = todo!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = todo != null;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(isEditing ? 'Edit Task' : 'Add Task',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Card(
          elevation: 3,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(children: [
              TextField(
                controller: _title,
                decoration: InputDecoration(
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _desc,
                decoration: InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: Icon(isEditing ? Icons.update : Icons.add,size: 23,),
                label: Text(isEditing ? 'Update Task' : 'Add Task',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                onPressed: () {
                  final t = _title.text.trim();
                  if (t.isEmpty) {
                    Get.snackbar('Error', 'Title cannot be empty',
                        snackPosition: SnackPosition.BOTTOM);
                    return;
                  }
                  final d = _desc.text.trim();
                  if (isEditing) {
                    c.updateTodo(todo!.id, t, d);
                  } else {
                    c.addTodo(t, d);
                  }
                  Get.back();
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}
