import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_sleep/home/home.dart';
import 'package:flutter_sleep/practices/friend_chat.dart';
import 'package:flutter_sleep/practices/layout_first.dart';
import 'package:flutter_sleep/practices/random_word.dart';
import 'package:flutter_sleep/practices/todo_list.dart';

// 自定义主题
final ThemeData kIosTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light
);
final ThemeData kAndroidTheme = new ThemeData(
   primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400]
);

void main() => runApp(MaterialApp(
  title: "MINE FLUTTER APP",
  theme: defaultTargetPlatform == TargetPlatform.iOS 
    ? kIosTheme
    : kAndroidTheme,
  initialRoute: "/",
  routes: {
    "/": (context) => Home(),
    LayoutFirst.routeName: (context) => LayoutFirst(),
    RandomWord.routeName: (context) => RandomWord(),
    TodoList.routeName: (context) => TodoList(),
    ChatScreen.routeName: (context) => ChatScreen()
  }
));

/**
 * 待理解： 
 *  1.onGenerateRoute页面传值
 *    https://api.flutter.dev/flutter/widgets/WidgetsApp/onGenerateRoute.html
 * 
 */