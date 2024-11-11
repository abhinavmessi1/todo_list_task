import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/todo_screen.dart';
import './view_model/todo_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        home: TodoScreen(),
      ),
    );
  }
}
