import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    var hintStyle = MaterialStateProperty.resolveWith((states) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
        fontStyle: FontStyle.italic,
        color: Colors.grey[600]
      )
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchBar(
        autoFocus: true,
        hintStyle: hintStyle,
        hintText: "Search tasks...",
      ),
    );
  }
}