import 'package:flutter/material.dart';


class ChatHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar:  AppBar(
          backgroundColor:  Color.fromARGB(200, 5, 88, 106),
          title: const Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(left: 20.0),),
              Text("Chatbot"),
            ],
          ),
        ),
        body: ChatBody(),
      ),
    );
  }
}
class ChatBody extends StatefulWidget {
  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {

  final TextEditingController textController = new TextEditingController();
  final List<ChatMessage> message_list = <ChatMessage>[];

  void button_sent(String text){
    textController.clear();
    ChatMessage message = new ChatMessage(text:text);
    setState(() {
      message_list.insert(0,message);
    });

  }
  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    return Container(
      width: maxWidth,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          Flexible(
            child:  ListView.builder(
              padding:  EdgeInsets.only(top:10.0,bottom: 10.0),
              reverse : true,
              itemBuilder: (_,int index) => message_list[index],
              itemCount: message_list.length,
            ),
          ),
          Divider(color: const Color.fromARGB(255, 64, 255, 239),height: 1.0,),
          Container(
            child:  Container(child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Message",),
                    controller: textController,
                    onSubmitted: button_sent,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),onPressed:()=> button_sent(textController.text),
                ),
              ],
            ),
            ),
          ),
        ],
      ),
    );
  }
}



class ChatMessage extends StatelessWidget {
  final String text;
  ChatMessage({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.only(right: 10.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Padding(padding: const EdgeInsets.only(right: 16.0),),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Dalal",style: TextStyle(fontSize: 10.0,color:  Color.fromARGB(200, 5, 88, 106),),),
              Padding(padding: const EdgeInsets.only(top: 5.0),),
              ClipRect(
                child: Container(
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(maxWidth: 500.0),
                  decoration:  BoxDecoration(
                    color: Color.fromARGB(150, 5, 88, 106),

                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(text),),
              )

            ],
          ),
        ],
      ),
    );
  }
}