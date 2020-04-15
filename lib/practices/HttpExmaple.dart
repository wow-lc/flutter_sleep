import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// dio调用简单示例
class HttpExmaple extends StatefulWidget {
  static const routeName = "/httpExmaple";
  @override
  State<StatefulWidget> createState() {
    return HttpExmapleState();
  }
}

class HttpExmapleState extends State {
  String _result = "";

  @override
  Widget build(BuildContext context) {
    Future _getHttp(BuildContext context) async {
      try {
        Response response = await Dio().get("http://www.baidu.com");
        setState(() {
          _result = response.data;
        });
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("调用成功!")));
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('网络调用')),
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: RefreshIndicator(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  RaisedButton(
                    onPressed: () {
                      _getHttp(context);
                    },
                    child: Text("提交"),
                  ),
                  Text("获取到的参数： $_result"),
                ]),
              ),
              onRefresh: () {
                _getHttp(context);
              },
            ),
          );
        },
      ),
    );
  }
}
