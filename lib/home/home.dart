import 'package:flutter/material.dart';

import 'dart:math' as math;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bottomChildren = <Widget>[
      IconButton(
        icon: Icon(Icons.home),
        color: _selectedIndex == 0 ? Colors.red : Colors.grey,
        onPressed: () {
          _onItemTap(0);
        },
      ),
      IconButton(
        icon: Icon(Icons.search),
        color: _selectedIndex == 1 ? Colors.red : Colors.grey,
        onPressed: () {
          _onItemTap(1);
        },
      ),
      IconButton(
        icon: Icon(Icons.photo_filter),
        color: _selectedIndex == 3 ? Colors.red : Colors.grey,
        onPressed: () {
          _onItemTap(3);
        },
      ),
      IconButton(
        icon: Icon(Icons.face),
        color: _selectedIndex == 4 ? Colors.red : Colors.grey,
        onPressed: () {
          _onItemTap(4);
        },
      ),
    ];

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
      body: HomeGrid(),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: bottomChildren)),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: _selectedIndex == 2 ? Colors.red : Colors.grey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.add,
            color: Colors.white,
          )
        ]),
        onPressed: () => {
          setState(() {
            _selectedIndex = 2;
          })
        },
      ),
      floatingActionButtonLocation:
          _CenterDockedFloatingActionButtonLocation(_selectedIndex),
    );
  }
}

// home主界面
class HomeGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    // 宫格导航
    Widget _cell(
        String label, String routeName, IconData iconData, Color color) {
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
        onTap: () async {
          // 采用async await,获取到Navigator.pop返回数据
          print("跳转" + routeName);
          // 可通过arguments属性传递
          final result = await Navigator.pushNamed(context, routeName);
          print(result);
        },
      ));
    }

    return Center(
        child: Container(
            margin: const EdgeInsets.all(16.0),
            child: Table(children: [
              TableRow(children: [
                _cell("单词列表", "/randomWord", Icons.ac_unit, primaryColor),
                _cell("布局一", "/layoutFirst", Icons.layers, primaryColor),
                _cell(
                    "待办列表", "/todoList", Icons.featured_play_list, primaryColor)
              ]),
              TableRow(children: [
                _cell("聊天chat", "/chatScreen", Icons.chat, primaryColor),
                _cell("电量管理", "/batteryManger", Icons.battery_charging_full,
                    primaryColor),
                _cell("动 画", "/animation", Icons.crop_rotate, primaryColor)
              ]),
              TableRow(children: [
                _cell("网络请求", "/httpExmaple", Icons.http, primaryColor),
                _cell("电量管理", "/batteryManger", Icons.battery_charging_full,
                    primaryColor),
                _cell("路由拦截", "/needLogin", Icons.not_interested, primaryColor)
              ])
            ])));
  }
}

abstract class _DockedFloatingActionButtonLocation
    extends FloatingActionButtonLocation {
  const _DockedFloatingActionButtonLocation();

  // Positions the Y coordinate of the [FloatingActionButton] at a height
  // where it docks to the [BottomAppBar].
  @protected
  double getDockedY(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double contentBottom = scaffoldGeometry.contentBottom;
    final double bottomSheetHeight = scaffoldGeometry.bottomSheetSize.height;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final double snackBarHeight = scaffoldGeometry.snackBarSize.height;

    double fabY = contentBottom - fabHeight / 2.0;
    // The FAB should sit with a margin between it and the snack bar.
    if (snackBarHeight > 0.0)
      fabY = math.min(
          fabY,
          contentBottom -
              snackBarHeight -
              fabHeight -
              kFloatingActionButtonMargin);
    // The FAB should sit with its center in front of the top of the bottom sheet.
    if (bottomSheetHeight > 0.0)
      fabY =
          math.min(fabY, contentBottom - bottomSheetHeight - fabHeight / 2.0);

    final double maxFabY = scaffoldGeometry.scaffoldSize.height - fabHeight;
    return math.min(maxFabY, fabY);
  }
}

class _CenterDockedFloatingActionButtonLocation
    extends _DockedFloatingActionButtonLocation {
  const _CenterDockedFloatingActionButtonLocation(
    this.positionX,
  );

  final int positionX;

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        4 *
        this.positionX;
    return Offset(fabX, getDockedY(scaffoldGeometry));
  }

  @override
  String toString() => 'FloatingActionButtonLocation.centerDocked';
}
