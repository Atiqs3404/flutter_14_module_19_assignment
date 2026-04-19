import 'package:flutter/material.dart';
import 'package:todo_app/controller/todoController.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  TodoController todoController = TodoController();

  Future<void> fetchData() async {
    await todoController.getTasks();

    if (mounted) setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  void taskDialog(
    bool isUpdate, {
    Map<String, dynamic>? task,
    String? title,
    String? description,
  }) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    if (isUpdate && task != null) {
      title ??= task["title"] as String?;
      description ??= task["description"] as String?;
      titleController.text = title!;
      descriptionController.text = description!;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isUpdate ? "Update task" : "Add task"),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: "Title",
              ),
            ),

            SizedBox(height: 5),

            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: "Description",
              ),
            ),

            SizedBox(height: 5),

            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (isUpdate) {
                      todoController.updateTasks(
                        task!["_id"],
                        title: titleController.text,
                        description: descriptionController.text,
                      );
                    } else {
                      todoController.createTasks(
                        title: titleController.text,
                        description: descriptionController.text,
                      );
                    }

                    Navigator.pop(context);

                    await fetchData();
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),

        centerTitle: true,

        backgroundColor: Colors.deepOrange,
      ),

      body: ListView.builder(
        itemCount: todoController.taskList.length,

        itemBuilder: (context, index) {
          final task = todoController.taskList[index] as Map<String, dynamic>;

          return ListTile(
            leading: IconButton(
              onPressed: () {
                taskDialog(true, task: task);
              },
              icon: Icon(Icons.edit),
            ),

            title: Text(task["title"]),

            subtitle: Text(task["description"]),

            trailing: IconButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                final value = await todoController.deleteTasks(task["_id"]);
                await fetchData();

                if (value) {
                  messenger.showSnackBar(
                    SnackBar(content: Text("Item deleted")),
                  );
                } else {
                  messenger.showSnackBar(
                    SnackBar(content: Text("Something went wrong!!!")),
                  );
                }
              },
              icon: Icon(Icons.delete),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          taskDialog(false);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
