import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../utils/local_storage.dart';

// Provider class to manage the task states
class TaskProvider extends ChangeNotifier {

  LocalStorage storage;
  List<TaskModel> _tasks = [];

  // Constructor initializing with local storage and initial tasks
  TaskProvider({required this.storage, required tasks}) {
    _tasks = tasks;
  }

  // Getter for retrieving non-completed tasks
  List<TaskModel> get tasks => _tasks.where((task) => task.isCompleted == false).toList();

  // Getter for retrieving completed tasks
  List<TaskModel> get completedTasks => _tasks.where((task) => task.isCompleted == true).toList();

  // Method to add a new task
  void addTask(TaskModel newTask) async {
    _tasks.add(newTask); // Add the new task to the list
    storage.writeTask(_tasks); // Save the updated list to local storage
    notifyListeners(); // Notify listeners to propagate changes
  }

  // Method to remove a task
  void removeTask(TaskModel task) async {
    _tasks.remove(task); // Remove the task from the list
    storage.writeTask(_tasks); // Update the local storage
    notifyListeners(); // Notify listeners to propagate changes
  }

  // Method to toggle a task's completion status
  bool completeTask(TaskModel task) {
    task.toggleCompleted(); // Toggle the completion status of te TaskModel
    storage.writeTask(_tasks); // Update the local storage
    notifyListeners(); // Notify listeners to propagate changes
    return task.isCompleted;
  }

  // Method to edit a task's name
  void updateTask(TaskModel? task, String text) async {
    task!.taskName = text; // Update the task's name
    storage.writeTask(_tasks); // Update the local storage
    notifyListeners(); // Notify listeners to propagate changes
  }

}