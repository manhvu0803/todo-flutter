import 'package:flutter/material.dart';
import 'package:todo/date_time_extension.dart';
import 'package:todo/task.dart';
import 'package:todo/task_database.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final DateTime time;
  final Task? task;

  const TaskCard({super.key, required this.title, required this.subtitle, required this.isCompleted, required this.time, this.task});

  factory TaskCard.fromTask(Task task) {
    return TaskCard(
      title: task.title,
      subtitle: task.note,
      isCompleted: task.isCompleted,
      time: task.time,
      task: task,
    );
  }

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Checkbox(
              value: _isCompleted,
              onChanged: (checked) {
                if (widget.task != null) {
                  widget.task!.isCompleted = checked ?? false;
                  TaskDatabase.notifyChange();
                }

                setState(() => _isCompleted = checked ?? false);
              }
            ),
            title: Text(widget.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.subtitle),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_month),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, top: 2),
                      child: Text("${widget.time.dateString()} ${widget.time.timeOfDayString()}"),
                    )
                  ],
                ),
                const SizedBox(height: 8)
              ],
            ),
          )
        ],
      ),
    );
  }
}