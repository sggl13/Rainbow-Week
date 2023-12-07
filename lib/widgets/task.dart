import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rainbow_week/providers/task_provider.dart';
import '../models/task_model.dart';
import '../utils/app_colors.dart';
import 'task_dialogue.dart';

// A StatelessWidget that represents a single task item
class Task extends StatelessWidget {

  final TaskModel task; // Task model object containing the data to populate the widget

  const Task({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set width and height relative to screen size
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: TASK_COLORS[task.colorIndex], // Background color based on task's color index
      ),
      child: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.05), // Spacing and layout for task elements relative to screen size
          Expanded(
            child: Text(
              task.taskName,
              overflow: TextOverflow.ellipsis, // Text overflow handling
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          GestureDetector(
            onTap: () => showDialog(
              context: context,
              barrierDismissible: true,
              barrierColor: Colors.black38,
              builder: (c) => TaskDialog(
                task: task,
                taskName: task.taskName,
                isEdit: true,
              ),
            ),
            child: const Icon(
              Icons.edit,
              size: 26,
              color: Colors.black
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          GestureDetector(
            onTap: () => deleteTask(context),
            child: const Icon(
              Icons.delete,
              size: 26,
              color: Colors.red,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.035),
          Checkbox(
            value: task.isCompleted,
            activeColor: Colors.green.shade800,
            checkColor: Colors.green.shade800,
            onChanged: (_) => completeTask(context)
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        ],
      ),
    );
  }

  // Method to delete the task
  void deleteTask(BuildContext context) {
    // Provider logic to remove the task
    final provider = Provider.of<TaskProvider>(context, listen: false);
    provider.removeTask(task);

    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Dismiss any current snackbar
    ScaffoldMessenger.of(context).showSnackBar( // Display snackbar to indicate task was deleted
      const SnackBar(content: Text('Task deleted.')),
    );
  }

  // Method to mark the task as completed/incomplete
  void completeTask(BuildContext context) {
    // Provider logic to mark a task as completed/incomplete
    final provider = Provider.of<TaskProvider>(context, listen: false);
    final isCompleted = provider.completeTask(task);

    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Dismiss any current snackbar
    ScaffoldMessenger.of(context).showSnackBar( // Display snackbar to indicate task was completed/incomplete
      SnackBar(content: Text(isCompleted ? 'Task completed.' : 'Task incomplete.')),
    );
  }

}