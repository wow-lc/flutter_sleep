import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// 获取当前屏幕
MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);

class AnimationExample extends StatelessWidget {
  static const routeName = "/animation";

  @override
  Widget build(BuildContext context) {
    _rowWidget({children}) {
      List<Widget> widgetList = [];
      for (var widget in children) {
        widgetList.add(
          Expanded(
            flex: 1,
            child: Center(child: widget),
          ),
        );
      }

      return Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widgetList,
          ));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("动画实例"),
        ),
        body: ListView(
          children: [
            _rowWidget(children: [
              AnimatedExmaple(),
              OpacityExmaple(),
            ]),
            _rowWidget(children: [HeroExmaple(), TransformExmaple()]),
            _rowWidget(children: [
              AnimatedBuilderExmaple(),
              AnimatedBuildTweenExmaple()
            ])
          ],
        ));
  }
}

// AnimatedContainer 组件动画示例
class AnimatedExmaple extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimatedExmapleState();
  }
}

class AnimatedExmapleState extends State {
  bool _flag = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _flag = !_flag;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 700),
          width: mediaQuery.size.width * 0.4,
          height: _flag ? 150 : 50,
          color: _flag ? Colors.red : Colors.blue[300],
          child: Center(
              child: Text(
            "AnimatedContainer",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ));
  }
}

// Opacity组件示例
class OpacityExmaple extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OpacityExmapleState();
  }
}

class OpacityExmapleState extends State {
  bool _flag = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _flag = !_flag;
          });
        },
        child: Container(
          width: mediaQuery.size.width * 0.4,
          height: 150.0,
          child: Stack(
            children: <Widget>[
              Image.asset(
                'images/lake.jpg',
                fit: BoxFit.fill,
              ),
              AnimatedOpacity(
                  opacity: _flag ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 300),
                  child: Container(
                      color: Colors.black,
                      child: Center(
                          child: Text(
                        "AnimatedOpacity",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )))),
            ],
          ),
        ));
  }
}

// hero组件示例
class HeroExmaple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _gotoLayout() {
      Navigator.pushNamed(context, "/layoutFirst");
    }

    return GestureDetector(
      onTap: _gotoLayout,
      child: Hero(
          tag: "lake-img",
          child: Image.asset(
            'images/lake.jpg',
            fit: BoxFit.fill,
            width: mediaQuery.size.width * 0.4,
          )),
    );
  }
}

// Transform示例
class TransformExmaple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 4,
      child: Container(
        width: 100,
        height: 100.0,
        color: Colors.greenAccent,
        child: Text("Transform"),
      ),
    );
  }
}

// AnimatedBuilder + AnimationController示例
class AnimatedBuilderExmaple extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimatedBuilderExmapleState();
  }
}

class AnimatedBuilderExmapleState extends State
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 4), vsync: this)
          ..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext buildContext, Widget child) {
        return Transform.rotate(
            angle: _animationController.value * 2.0 * pi, child: child);
      },
      child: Image.asset(
        'images/lake.jpg',
        fit: BoxFit.fill,
        width: mediaQuery.size.width * 0.4,
      ),
    );
  }
}

// AnimatedBuilder + Tween示例
class AnimatedBuildTweenExmaple extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimatedBuildTweenExmapleState();
  }
}

class AnimatedBuildTweenExmapleState extends State
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final animation =
        Tween(begin: 0, end: 2 * pi).animate(_animationController);
    
    return AnimatedBuilder(
      animation: animation,
      child: Container(
        width: 100.0,
        height: 100.0,
        color: Colors.green,
        child: Center(
          child: Text("AnimatedBuilder + Tween"),
        ),
      ),
      builder: (BuildContext context, Widget child) {
        return Transform.rotate(
            angle: _animationController.value, child: child);
      },
    );
  }
}
