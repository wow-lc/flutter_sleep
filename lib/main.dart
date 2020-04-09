import 'package:flutter/material.dart';

import 'package:flutter_sleep/home/home.dart';
import 'package:flutter_sleep/layout_first/layout_first.dart';
import 'package:flutter_sleep/random_word/random_word.dart';

void main() => runApp(MaterialApp(
  title: "MINE FLUTTER APP",
  initialRoute: "/",
  routes: {
    "/": (context) => Home(),
    "/layoutFirst": (context) => LayoutFirst(),
    "/randonWord": (context) => RandomWord()
  }
));