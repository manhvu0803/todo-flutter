import 'package:flutter/material.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 65,
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: "All"),
              Tab(text: "Today"),
              Tab(text: "Upcoming")
            ]
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              Text("All tasks"),
              Text("Today tasks"),
              Text("Upcoming tasks"),
            ]
          ),
        )
      ],
    );
  }
}