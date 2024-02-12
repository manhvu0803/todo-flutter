import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final DateTime time;

  const TaskCard({super.key, required this.title, required this.subtitle, required this.isCompleted, required this.time});

  const TaskCard.fromTask({super.key, required this.title, required this.subtitle, required this.isCompleted, required this.time});

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
              onChanged: (checked) => setState(() => _isCompleted = checked ?? false)
            ),
            title: Text(widget.title),
            subtitle: Text(widget.subtitle),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: Text("${widget.time.year}/${widget.time.month}/${widget.time.day} ${widget.time.hour.toString().padLeft(2, "0")}:${widget.time.minute.toString().padLeft(2, "0")}")
          ),
        ],
      ),
    );
  }
}