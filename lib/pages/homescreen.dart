import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import 'to_do_form_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController c = Get.put(HomeController());
  bool _searching = false;
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 4,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.indigo, Colors.deepPurple]),
          ),
        ),
        title: !_searching
            ? Text('My Tasks', style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white,fontSize: 28,))
            : TextField(
          controller: _searchCtrl,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: 'Search tasks...',
            hintStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.search, color: Colors.white),
            suffixIcon: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                _searchCtrl.clear();
                c.search('');
                setState(() => _searching = false);
              },
            ),
            border: InputBorder.none,
          ),
          onChanged: c.search,
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(_searching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() => _searching = !_searching);
              if (!_searching) {
                _searchCtrl.clear();
                c.search('');
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        final list = c.filteredTodos;
        if (list.isEmpty) {
          return Center(child: Text('No tasks found 😊'));
        }
        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: list.length,
          itemBuilder: (_, i) {
            final t = list[i];
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: Checkbox(
                  value: t.isDone,
                  onChanged: (_) => c.toggleDone(t.id),
                ),
                title: Text(
                  t.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    decoration: t.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: t.description.isNotEmpty ? Text(t.description) : null,
                trailing: Wrap(children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Get.to(() => TodoFormView(todo: t)),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => c.deleteTodo(t.id),
                  ),
                ]),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: () => Get.to(() => TodoFormView()),
      ),
    );
  }
}
