import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
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
      child: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(text: "All"),
                Tab(text: "Today"),
                Tab(text: "Upcoming")
              ]
            ),
          ),
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
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}