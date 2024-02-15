import 'package:todo/task.dart';

class TaskDatabase {
  static final Set<Function()> _listeners = {};

  static List<Task> tasks = [];

  static void notifyChange() {
    for (var listener in _listeners) {
      listener();
    }
  }

  static void addListener(Function() callback) {
    _listeners.add(callback);
  }

  static void removeListener(Function() callback) {
    _listeners.remove(callback);
  }
}