import 'package:hive/hive.dart';
part 'task_model.g.dart'; // For Hive auto-generated code, used for the Hive adapter

@HiveType(typeId: 1) // Hive type annotation with a unique typeId
class TaskModel {

  @HiveField(0) // Hive field for the auto-generated file
  final String taskId;

  @HiveField(1)
  String taskName;

  @HiveField(2)
  int colorIndex;

  @HiveField(3)
  bool isCompleted;

  TaskModel({required this.taskId, required this.taskName, required this.colorIndex, this.isCompleted = false});

  // Method to toggle the completion status of the task
  void toggleCompleted() => isCompleted = !isCompleted;

}