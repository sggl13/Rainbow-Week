import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rainbow_week/widgets/task.dart';
import '../providers/task_provider.dart';

// StatelessWidget to show incomplete/ongoing tasks
class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider logic to get current incomplete/ongoing tasks
    final provider = Provider.of<TaskProvider>(context);
    final tasks = provider.tasks;

    // If there a no tasks, show text message, else return list of tasks
    return tasks.isEmpty
      ? const Center(
          child: Text(
            'You have no tasks yet.'
          ),
        )
      : ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: tasks.length,
        separatorBuilder: (context, index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01,), // Set separator height relative to screen size
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Task(task: task);
        }
    );
  }

}