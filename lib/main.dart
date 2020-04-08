import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 标题
    Widget titleSection = new Container( // 只有Container才有添加填充，边距，边框或背景色属性s
      padding: const EdgeInsets.all(32.0),
      child: new Row(children: [
        new Expanded(
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    'Oeschinen Lake Campground',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              new Text("Kandersteg, Switzerland")
            ])),
        new Icon(
          Icons.star,
          color: Colors.red[500],
        ),
        new Text('41')
      ]),
    );

    // 单个按钮组件
    Column buildButtomColumn(IconData icon,String label) {
      Color color = Theme.of(context).primaryColor;

      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Icon(icon, color: color),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color
              ),
            )
          )
        ]
      );
    }

    // 中间按钮
    Widget buttonSection =  new Container(
      child: new Row(
        // 主轴排列方式  spaceEvenly 平均间隔
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          buildButtomColumn(Icons.call, "call"),
          buildButtomColumn(Icons.near_me, "Route"),
          buildButtomColumn(Icons.share, "share"),
        ]
      )
    );

    // 文本内容
    Widget textSection = new Card(
      margin: const EdgeInsets.only(top: 8.0),
      child: new Container(
        padding: const EdgeInsets.all(32.0),
        child: new Text(
          "Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.",
          softWrap: true,
        ),
      )
    );

    // 评分组件
    var ratings = new Container(
      padding: new EdgeInsets.all(20.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new Icon(Icons.star, color: Colors.black),
              new Icon(Icons.star, color: Colors.black),
              new Icon(Icons.star, color: Colors.black),
              new Icon(Icons.star, color: Colors.black),
              new Icon(Icons.star, color: Colors.black),
            ],
          ),
          new Text(
            '170 Reviews',
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );

    return new MaterialApp(
        title: 'Welcome to Flutter',
        home: new Scaffold(
          body: new ListView(
            children: [
              new Image.asset(
                'images/lake.jpg',
                width: 600.0,
                height: 240.0,
                fit: BoxFit.cover,
              ),
              titleSection,
              buttonSection,
              textSection,
              ratings
            ],
          ),
        )
    );
  }
}

/**
 * 单词： 
 *  widget 组件           axis 轴       cross axis 副轴
 *  alignMent 对准/对齐   expand 展开
 * 
 * 笔记:
 * 1. 所有布局widget,都有child或者children属性用于放置组件
 * 2. Row 水平布局(主轴水平布局),Col 垂直布局(主轴垂直布局), 俩者都需要子widget, 当然可用于flex属性设置权重
 * 3. 当内容过长时,可以使用Expanded组件
 */