import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 宫格导航
    Widget _cell(String label, String routeName, Color color) {
      return Card(
          child: GestureDetector(
        child: Container(
            height: 80.0,
            color: color,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.ac_unit,
                    color: Colors.white,
                  ),
                  Text(
                    label,
                    style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ])),
        onTap: () {
          print("跳转" + routeName);
          Navigator.pushNamed(context, routeName);
        },
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home Route'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.list,
                color: Colors.white,
              ),
              onPressed: null)
        ],
      ),
      body: Center(
          child: Container(
              margin: const EdgeInsets.all(16.0),
              child: Table(children: [
                TableRow(children: [
                  _cell("单词列表", "/randonWord", Colors.blue[200]),
                  _cell("布局一", "/layoutFirst", Colors.blue[400]),
                  // _cell('露西',Colors.blue[600])
                ]),
                TableRow(children: [
                  _cell("单词列表", "/randonWord", Colors.blue[200]),
                  _cell("布局一", "/layoutFirst", Colors.blue[400]),
                  // _cell('露西',Colors.blue[600])
                ])
              ]))),
    );
  }
}
