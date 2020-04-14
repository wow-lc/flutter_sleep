import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
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
                  _cell("单词列表", "/randomWord",Icons.ac_unit, primaryColor),
                  _cell("布局一", "/layoutFirst",Icons.layers, primaryColor),
                  _cell("待办列表", "/todoList",Icons.featured_play_list, primaryColor)
                ]),
                TableRow(children: [
                  _cell("聊天chat", "/chatScreen",Icons.chat, primaryColor),
                  _cell("电量管理", "/batteryManger",Icons.battery_charging_full, primaryColor),
                  _cell("动 画", "/animation",Icons.crop_rotate, primaryColor)
                ])
              ]))),
    );
  }
}
