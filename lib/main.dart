import 'package:flutter/material.dart';
import 'data/datasources/app_database.dart';
import 'data/repositories/task_repository_impl.dart';
import 'domain/repositories/task_repository.dart';
import 'presentation/screens/task_screen.dart';

// [NOTEBOOK] Global dependencies initialized at app startup
late final AppDatabase database;
late final TaskRepository taskRepository;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize SQLite Drift Engine
  database = AppDatabase();

  // 2. Bind the Repository implementation
  taskRepository = TaskRepositoryImpl(database);

  runApp(const MomentumApp());
}

class MomentumApp extends StatelessWidget {
  const MomentumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Momentum',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      // Pass the repository down cleanly to the presentation layer screen
      home: TaskScreen(taskRepository: taskRepository),
    );
  }
}