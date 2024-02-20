import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as timezone;
import 'package:todo/add_task_page.dart';
import 'package:todo/search_view.dart';
import 'package:todo/task_database.dart';
import 'package:todo/tasks_view.dart';

Future<void> main() async {
  runApp(const TodoApp());
  timezone.initializeTimeZones();
  var notificationPlugin = FlutterLocalNotificationsPlugin();
  await notificationPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  await notificationPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();
  await notificationPlugin.initialize(const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher')));
  TaskDatabase.notification = notificationPlugin;
  TaskDatabase.notifyChange();
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
          fontSizeFactor: 1.1
        )
      ),
      home: const MainScreen()
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: (selectedPageIndex == 0) ? const TasksView() : const SearchView(),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index) => setState(() => selectedPageIndex = index),
          selectedIndex: selectedPageIndex,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.search), label: "Search"),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTaskPage())),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}