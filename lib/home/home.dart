import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 宫格导航
    Widget _cell(String label, String routeName, IconData iconData, Color color) {
      return Card(
        child: GestureDetector(
          child: Container(
              height: 80.0,
              color: color,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      iconData,
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
          onTap: () async { // 采用async await,获取到Navigator.pop返回数据
            print("跳转" + routeName);
            // 可通过arguments属性传递
            final result = await Navigator.pushNamed(context, routeName);
            print(result);
          },
        )
      );
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
                  _cell("单词列表", "/randomWord",Icons.ac_unit, Colors.blue[200]),
                  _cell("布局一", "/layoutFirst",Icons.layers, Colors.blue[400]),
                  _cell("待办列表", "/todoList",Icons.featured_play_list, Colors.blue[600])
                ]),
                TableRow(children: [
                  _cell("单词列表", "/randomWord",Icons.ac_unit, Colors.blue[200]),
                  _cell("布局一", "/layoutFirst",Icons.layers, Colors.blue[400]),
                  _cell("待办列表", "/todoList",Icons.featured_play_list, Colors.blue[600])
                ])
              ]))),
    );
  }
}
