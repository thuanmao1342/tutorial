import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    void _pushSaved() {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) {
            final tiles = _saved.map(
              (pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                  trailing: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                    semanticLabel: 'Remove from saved',
                  ),
                  onTap: () {
                    setState(() {
                      _saved.remove(pair);
                    });
                  },
                );
              },
            );
            return Scaffold(
              appBar: AppBar(
                title: const Text('Saved Suggestions'),
              ),
              body: ListView(
                  children: ListTile.divideTiles(
                context: context,
                tiles: tiles,
              ).toList()),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Suggestions"),
        actions: [
          IconButton(
            onPressed: _pushSaved,
            icon: const Icon(Icons.list),
            tooltip: 'Saved Suggestions',
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return const Divider(
              thickness: 5,
              color: Colors.blueAccent,
            );
          }

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          final alreadySaved = _saved.contains(_suggestions[index]);
          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : Colors.black,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  debugPrint('Removing ${_suggestions[index].asPascalCase}');
                  _saved.remove(_suggestions[index]);
                } else {
                  debugPrint('Adding ${_suggestions[index].asPascalCase}');
                  _saved.add(_suggestions[index]);
                }
              });
            },
          );
        },
      ),
    );
  }
}
