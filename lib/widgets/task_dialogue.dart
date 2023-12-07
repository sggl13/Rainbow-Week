import 'package:flutter/material.dart';
import '../models/task_model.dart';
import 'task_form.dart';

// A StatefulWidget that represents a dialog for adding or editing tasks
class TaskDialog extends StatefulWidget {

  // Optional task model for editing, with default name and edit status
  final TaskModel? task;
  late String taskName;
  final bool isEdit;

  TaskDialog({super.key, this.task, this.taskName = '', this.isEdit = false});

  @override
  _AddTaskDialog createState() => _AddTaskDialog();
}

class _AddTaskDialog extends State<TaskDialog> {

  @override
  Widget build(BuildContext context) => AlertDialog(
    backgroundColor: Colors.black54,
    scrollable: true,
    content: Column( // Column layout for the content
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.isEdit ? 'EDIT TASK' : 'ADD A NEW TASK', // Displays either 'EDIT TASK' or 'ADD A NEW TASK'
          style: const TextStyle(
              fontSize: 22,
              color: Colors.white
          ),
        ),
        // Embeds the TaskForm widget passing the task, task name, and edit status
        TaskForm(task: widget.task, taskName: widget.taskName, isEdit: widget.isEdit)
      ],
    ),
  );
}