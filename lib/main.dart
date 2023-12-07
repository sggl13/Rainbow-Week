import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rainbow_week/models/task_model.dart';
import 'package:rainbow_week/providers/task_provider.dart';
import 'package:rainbow_week/screens/home.dart';
import 'package:rainbow_week/utils/local_storage.dart';
import 'package:rainbow_week/widgets/rainbow_text.dart';

// Declaring global variables for storage and tasks
late final LocalStorage storage;
late final List<TaskModel> tasks;

Future<void> main() async {
  // Registering the TaskModelAdapter for Hive database
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());
  
  // Initializing Hive for Flutter
  await Hive.initFlutter();
  
  // Opening a Hive box to store tasks
  await Hive.openBox('taskBox');
  
  // Initializing storage and reading tasks from local storage
  storage = LocalStorage();
  tasks = await storage.readTasks();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider for state management
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
		  // Creating an instance of TaskProvider with initial data
          create: (context) => TaskProvider(
            storage: storage,
            tasks: tasks
          ),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          primaryColor: Colors.black,
          useMaterial3: true,
          visualDensity: VisualDensity.compact
        ),
        home: Home(), // Setting Home as the starting screen of the app
      ),
    );
  }
}