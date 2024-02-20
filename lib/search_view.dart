import 'package:flutter/material.dart';
import 'package:todo/task_card.dart';
import 'package:todo/task_database.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<Widget> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    var hintStyle = MaterialStateProperty.resolveWith((states) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
        fontStyle: FontStyle.italic,
        color: Colors.grey[600]
      )
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SearchBar(
            autoFocus: true,
            hintStyle: hintStyle,
            hintText: "Search tasks...",
            onSubmitted: _search,
          ),
        ),
        Expanded(child: ListView(children: _searchResults))
      ],
    );
  }

  void _search(String string) {
    final cards = <Widget>[];

    for (var task in TaskDatabase.tasks) {
      if (task.title.contains(string) || task.note.contains(string)) {
        cards.add(TaskCard.fromTask(task));
      }
    }

    setState(() => _searchResults = cards);
  }
}