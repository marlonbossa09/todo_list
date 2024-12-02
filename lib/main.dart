import 'package:flutter/material.dart';
import 'package:flutter_todo/screens/TaskScreen/TaskScreen.dart';
import 'package:flutter_todo/viewModels/TaskViewModel/TaskViewModels.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskViewModel()..fetchTasks(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskScreen(),
    );
  }
}
