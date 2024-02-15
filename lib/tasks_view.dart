import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/date_time_extension.dart';
import 'package:todo/task.dart';
import 'package:todo/task_card.dart';
import 'package:todo/task_database.dart';

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
    TaskDatabase.addListener(_onTaskChange);
  }

  @override
  void dispose() {
    _tabController.dispose();
    TaskDatabase.removeListener(_onTaskChange);
    super.dispose();
  }

  void _onTaskChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

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
            children: [
              // All
              getTaskTab((task) => true),
              // Today
              getTaskTab((task) => !task.isCompleted && task.time.compareDate(now) == 0),
              // Upcoming
              getTaskTab((task) => !task.isCompleted && task.time.compareDate(now) > 0)
            ]
          ),
        )
      ],
    );
  }

  Widget getTaskTab(bool Function(Task) isPassed) {
    final cards = <Widget>[];

    for (var task in TaskDatabase.tasks) {
      if (isPassed(task)) {
        cards.add(TaskCard.fromTask(task));
      }
    }

    return ListView(children: cards);
  }
}