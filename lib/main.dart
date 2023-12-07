import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rainbow_week/models/task_model.dart';
import 'package:rainbow_week/providers/task_provider.dart';
import 'package:rainbow_week/screens/home.dart';
import 'package:rainbow_week/utils/local_storage.dart';
import 'package:rainbow_week/widgets/rainbow_text.dart';

late final LocalStorage storage;
late final List<TaskModel> tasks;

Future<void> main() async {
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());
  await Hive.initFlutter();
  await Hive.openBox('taskBox');
  storage = LocalStorage();
  tasks = await storage.readTasks();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
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
        home: Home(),
      ),
    );
  }
}