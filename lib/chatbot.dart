import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBody extends StatefulWidget {
  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  final TextEditingController textController = new TextEditingController();
  final List<ChatMessage> messageList = <ChatMessage>[];
  bool isSendingMessage = false;
  bool isLoading = false;

  void _sendMessage(String text) async {
    textController.clear();
    setState(() {
      isSendingMessage = true;
    });

    // Display user message
    ChatMessage userMessage = ChatMessage(text: text, isUser: true,isLoading: isLoading );
    setState(() {
      messageList.add(userMessage);
    });

    try {
      setState(() {
        isLoading = true;
      });
      // Send a POST request to the Node.js API
      final response = await http.post(
        Uri.parse('https://skinscan-chatbot.onrender.com/SkinScan-Chatbot'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': text}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        String assistantReply = data['response'];

        ChatMessage assistantMessage = ChatMessage(text: assistantReply, isUser: false,isLoading: false,);
        setState(() {
          messageList.add(assistantMessage);
        });
      } else {
        // Display an error message if the response status is not 200
        ChatMessage assistantMessage = ChatMessage(
          text: 'Something went wrong! Please try later.',
          isUser: false,
          isLoading: false,
        );
        setState(() {
          messageList.add(assistantMessage);
        });
      }
    } catch (error) {
      // Display an error message if an exception occurs
      ChatMessage assistantMessage = ChatMessage(
        text: 'Something went wrong! Please try later.',
        isUser: false,
        isLoading: false,
      );
      setState(() {
        messageList.add(assistantMessage);
      });
    } finally {
      setState(() {
        isSendingMessage = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white60,
            image: DecorationImage(
              opacity: 0.5,
              image: AssetImage('assets/chatbot.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  reverse: false,
                  itemBuilder: (_, int index) => messageList[index],
                  itemCount: messageList.length,
                ),
              ),
              Divider(
                color: const Color.fromARGB(255, 64, 255, 239),
                height: 1.0,
              ),
              Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        enabled: !isLoading,
                        decoration: InputDecoration(
                          hintText: "Message",
                        ),
                        controller: textController,
                        onSubmitted: (text) => _sendMessage(text),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Color(0xff519e94),
                      ),
                        onPressed: isLoading ? null : () {
                          _sendMessage(textController.text);
                        }
                    ),
                    // Display loading indicator
                    if (isLoading)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isLoading; // add parameter

  ChatMessage({required this.text, this.isUser = true, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isUser ? const EdgeInsets.only(right: 10.0) : const EdgeInsets.only(left: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: const EdgeInsets.only(right: 16.0),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isUser ? "User" : "Assistant",
                  style: TextStyle(fontSize: 10.0, color: Color(0xff519e94), fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                ),
                ClipRect(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    constraints: BoxConstraints(maxWidth: 500.0),
                    decoration: BoxDecoration(
                      color: isUser ? Color(0xff519e94) : Colors.blueGrey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: isLoading ? Text('...',style: TextStyle(fontWeight: FontWeight.bold),) : Text(
                      text,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}