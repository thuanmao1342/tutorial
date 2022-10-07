import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWordSaved extends StatefulWidget {
  const RandomWordSaved({Key? key, required this.saved}) : super(key: key);

  final Set<WordPair> saved;

  @override
  _RandomWordSavedState createState() => _RandomWordSavedState();
}

class _RandomWordSavedState extends State<RandomWordSaved> {
  final _biggerFont = const TextStyle(fontSize: 18);
  final _saved = <WordPair>[];

  @override
  void initState() {
    _saved.addAll(widget.saved);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Suggestions'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _saved.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(
              _saved[i].asPascalCase,
              style: _biggerFont,
            ),
            trailing: const Icon(
              Icons.remove_circle,
              color: Colors.red,
            ),
            onTap: () {
              setState(() {
                widget.saved.remove(_saved[i]);
                _saved.remove(_saved[i]);
              });
              debugPrint('saved:  $_saved');
            },
          );
        },
      ),
    );
  }
}
