import 'package:flutter/material.dart';
import 'package:todo/input_field.dart';
import 'package:todo/task.dart';
import 'package:todo/task_database.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});
  @override
  State<StatefulWidget> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  late DateTime _selectedDate;
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back)
        ),
        title: const Text("Add task"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InputField(
                title: 'Title',
                hint: 'Enter title here',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                isMultiline: true,
                controller: _noteController,
              ),
              InputField(
                title: 'Date',
                hint: "${_selectedDate.year}/${_selectedDate.month}/${_selectedDate.day}",
                onTap: () => _selectDate(context),
                widget: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
              ),
              InputField(
                title: 'Start Time',
                hint: _selectedTime.format(context),
                onTap: () => _selectTime(context),
                widget: IconButton(
                  onPressed: () => _selectTime(context),
                  icon: const Icon(
                    Icons.access_time_rounded,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            TaskDatabase.tasks.add(Task(
              title: _titleController.text,
              note: _noteController.text,
              time: _selectedDate.copyWith(
                hour: _selectedTime.hour,
                minute: _selectedTime.minute,
                millisecond: 0,
                microsecond: 0
              )
            ));
            TaskDatabase.notifyChange();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final selectedTime = await showDatePicker(context: context, firstDate: DateTime(now.year, now.month, now.day), lastDate: DateTime(now.year + 2, 1, 1));

    if (selectedTime != null && selectedTime != _selectedDate) {
      setState(() => _selectedDate = selectedTime);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (selectedTime != null && selectedTime != _selectedTime) {
      setState(() => _selectedTime = selectedTime);
    }
  }
}