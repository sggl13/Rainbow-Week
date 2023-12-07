import 'package:hive/hive.dart';

import '../models/task_model.dart';

class LocalStorage {

  // Main Box object to read and write from into local storage.
  Box box = Hive.box('taskBox');

  // List to hold maps when reading from local storage
  List storageList = [];

  // Method to wrtite tasks into local storage
  void writeTask(List<TaskModel> tasks) {
    box.put('tasks', tasks); // adding list of maps to local storage
  }

  // Method to read tasks from local storage
  Future<List<TaskModel>> readTasks() async {
    storageList = box.get('tasks') ?? []; // Initializing list from storage, assign empty list if null
    List<TaskModel> tasks = [];

    // Looping through the storage list to parse out Task objects from maps
    for (final map in storageList) {
      TaskModel task = TaskModel(
          taskId: map.taskId,
          taskName: map.taskName,
          colorIndex: map.colorIndex,
          isCompleted: map.isCompleted);
      tasks.add(task); // Adding Tasks back to normal Task list
    }
    return tasks;
  }

  // Method to clear all tasks
  void clearTasks() {
    storageList.clear();
    box.clear();
  }
}