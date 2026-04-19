import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Todo App", home: Todo());
  }
}
