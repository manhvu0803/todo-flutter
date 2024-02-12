class Task {
  String title;
  String note;
  DateTime time;
  bool isCompleted = false;

  Task({
    required this.title,
    required this.note,
    required this.time
  });
}