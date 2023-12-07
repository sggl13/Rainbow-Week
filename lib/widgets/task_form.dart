import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rainbow_week/providers/task_provider.dart';
import 'package:rainbow_week/utils/app_colors.dart';
import 'package:uuid/v1.dart';
import 'dart:math';
import '../models/task_model.dart';

// StatefulWidget for adding or editing tasks in the application
class TaskForm extends StatefulWidget {

  // Optional task model for editing, with default name and edit status
  final TaskModel? task;
  final String taskName;
  final bool isEdit;

  const TaskForm({super.key, this.task, this.taskName = '' , this.isEdit = false});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _taskNameController;


  @override
  Widget build(BuildContext context) {
    _taskNameController = TextEditingController(text: widget.taskName);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,), // Spacing and layout for the elements relative to screen size
          buildInputField(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          buildSaveBtn(),
        ],
      ),
    );
  }


  // Input field for the task name
  Widget buildInputField() => TextFormField(
    maxLines: 1,
    controller: _taskNameController,
    validator: (content) {
      if (content == null || content.isEmpty) {
        return 'Please enter a task name.';
      }
      return null;
    },
    style: TextStyle(
        fontSize: 16,
        color: Colors.white.withOpacity(0.8)
    ),
    decoration: InputDecoration(
        hintText: 'Task name.',
        hintStyle: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.5)
        )
    ),
  );


  // Button to save task
  Widget buildSaveBtn() => ElevatedButton(
    onPressed: () => widget.isEdit ? editTask() : saveTask(), // Returns different provider access for editing and saving a task
    child: const Text('Save'),
  );


  // Method to save a new task
  void saveTask(){
    if (_formKey.currentState!.validate()) { //Validates input text to ensure it is not empty
      final newTask = TaskModel( // Creates a new TaskModel with the inputs
          taskId: const UuidV1().generate(), // Unique ID using timestamp
          taskName: _taskNameController.text,
          colorIndex: Random().nextInt(TASK_COLORS.length)
      );

      // Provider logic to save the task state
      final provider = Provider.of<TaskProvider>(context, listen: false);
      provider.addTask(newTask);

      // Simple snackbar indicating the task has been saved.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New task added.')),
      );

      // Close dialog oafter task has been saved
      Navigator.of(context).pop();
    } else { return; }
  }


  // Method to edit a task
  void editTask(){
    if (_formKey.currentState!.validate()) { //Validates input text to ensure it is not empty

      // Provider logic to save the new task state
      final provider = Provider.of<TaskProvider>(context, listen: false);
      provider.updateTask(widget.task, _taskNameController.text);

      // Simple snackbar indicating the task has been edited.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task edited.')),
      );

      // Close dialog oafter task has been saved
      Navigator.of(context).pop();
    } else { return; }
  }
}