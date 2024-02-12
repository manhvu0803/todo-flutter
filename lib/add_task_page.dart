import 'package:flutter/material.dart';
import 'package:todo/input_field.dart';

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