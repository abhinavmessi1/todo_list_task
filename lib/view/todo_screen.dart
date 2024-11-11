import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/todo_provider.dart';

class TodoScreen extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TODO List'),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.blue, Colors.purple, Colors.pink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Text(
                'Plan Your Day',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: taskEntryField(todoProvider),
          ),
          Expanded(
            child: taskList(todoProvider),
          ),
        ],
      ),
    );
  }

  Row taskEntryField(TodoProvider todoProvider) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _taskController,
            decoration: const InputDecoration(
              labelText: 'Enter task ',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            if (_taskController.text.isNotEmpty) {
              todoProvider.addTask(_taskController.text);
              _taskController.clear();
            }
          },
        ),
      ],
    );
  }

  ListView taskList(TodoProvider todoProvider) {
    return ListView.builder(
      itemCount: todoProvider.tasks.length,
      itemBuilder: (context, index) {
        final task = todoProvider.tasks[index];
        return Card(
          color: task.isCompleted ? Colors.green : Colors.blue,
          child: ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                color: Colors.white,
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                todoProvider.toggleTaskCompletion(index);
              },
            ),
          ),
        );
      },
    );
  }
}
