import 'package:flutter/material.dart';

import 'package:flutter_sleep/home/home.dart';
import 'package:flutter_sleep/practices/layout_first.dart';
import 'package:flutter_sleep/practices/random_word.dart';
import 'package:flutter_sleep/practices/todo_list.dart';

void main() => runApp(MaterialApp(
  title: "MINE FLUTTER APP",
  initialRoute: "/",
  routes: {
    "/": (context) => Home(),
    LayoutFirst.routeName: (context) => LayoutFirst(),
    RandomWord.routeName: (context) => RandomWord(),
    TodoList.routeName: (context) => TodoList()
  }
));

/**
 * 待理解： 
 *  1.onGenerateRoute页面传值
 *    https://api.flutter.dev/flutter/widgets/WidgetsApp/onGenerateRoute.html
 * 
 */