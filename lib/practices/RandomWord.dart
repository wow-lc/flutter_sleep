import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// 有状态组件
class RandomWord extends StatefulWidget {
  static const routeName = "/randomWord";
  @override
  State<StatefulWidget> createState() {
    return RandomWordState();
  }
}

class RandomWordState extends State<RandomWord> {
  // 在Dart中 已“_”下划线前缀，会强制变成私有的
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  final _saved = new Set<WordPair>();

  Widget _buildSuggestion() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, i) {
          // 判断i是否为奇数
          if (i.isOdd) {
            return new Divider();
          }
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        // flutter中调用setState()会为State对象触发build()方法，从而触发UI的更新
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((pair) {
        return new ListTile(
            title: new Text(pair.asPascalCase, style: _biggerFont));
      });
      final divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return new Scaffold(
          appBar: new AppBar(title: new Text("save Suggestions")),
          body: new ListView(children: divided));
    }));
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    // return new Text(wordPair.asPascalCase);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Setup Name gengeator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestion(),
    );
  }
}
