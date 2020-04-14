import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// 聊天组件
class ChatScreen extends StatefulWidget {
  static const routeName = "/chatScreen";

  @override
  State<StatefulWidget> createState() {
    return ChatScreenState();
  }
  
}

// 聊天组件的state
class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _chatMessageList = <ChatMessage>[];
  bool _isComposing = false;
  
  void _handleSubmitted(String text) {
    _textController.clear();
    setState((){
      _isComposing = false;
    });
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: Duration(milliseconds: 300),
        vsync: this
      )
    );
    setState(() {
      _chatMessageList.insert(0, message);
    });
    message.animationController.forward();
  }

  Widget _buildTextComponent() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children:[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                onChanged: (String text) {
                  this.setState((){
                    _isComposing = text.length > 0;
                  });
                },
                decoration: InputDecoration.collapsed(hintText: 'send some messages'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send), 
                onPressed: _isComposing 
                  ? () => _handleSubmitted(_textController.text)
                  : null
              )
            )
          ]
        )
      ),
    );
  }

  @override
  void dispose() {
    for(ChatMessage message in _chatMessageList)
      message.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("friend chat"),
        elevation:
         Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _chatMessageList[index],
              itemCount: _chatMessageList.length,
            )
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor
            ),
            child: _buildTextComponent(),
          )
        ]
      )
    );
  }
}

// 消息框组件
class ChatMessage extends StatelessWidget{
  ChatMessage({this.text, this.animationController});
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    String _name = wordPair.asPascalCase;
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        axisAlignment: 0.0,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right:  16.0),
                child: CircleAvatar(child: Text(_name[0])),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_name, style: Theme.of(context).textTheme.subhead),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Text(text)
                    )
                  ]
                ),
              )
            ],
          )
        ),
      )
    );
  }
}

/**
 *  单词：
 *    curve 曲线
 * 
 *  笔记：
 *    1. IconTheme可以统一控制吧包裹Icon的样式主题
 */
