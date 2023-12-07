import 'package:flutter/material.dart';
import '../widgets/task_dialogue.dart';
import '../widgets/completed_list.dart';
import '../widgets/rainbow_text.dart';
import '../widgets/task_list.dart';
import '../utils/app_colors.dart';

// StatefulWidget that serves as the home screen of the application
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0; // Index to track the current screen

  @override
  Widget build(BuildContext context) {
    // Screens to display based on the selected index
    final screens = [
      TaskList(), // Screen for the list of tasks
      CompletedList(), // Screen for the list of completed tasks
    ];

    return Scaffold(
      // App bar with a centered title using RainbowText
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
          child: RainbowText(
            text: "RAINBOW LIST",
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold
            ),
            gradient: LinearGradient(colors: TITLE_COLORS),
          ),
        ),
      ),
      // Bottom navigation bar to switch between task screens
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {_currentIndex = index;}),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list, size: 20,),
            label: 'To-Do'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.done, size: 20,),
              label: 'Completed'
          ),
        ],
      ),
      // Floating action button to add a new task
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          context: context,
          barrierDismissible: true,
          barrierColor: Colors.black38,
          builder: (c) => TaskDialog(), // Opens dialog to add a new task
        ),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: screens[_currentIndex], // Display the current selected screen
    );
  }
}