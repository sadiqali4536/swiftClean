import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _botResponse("Hi");
  }

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add({
        "sender": "user",
        "text": message,
        "time": DateTime.now(),
      });
    });

    _controller.clear();
    _botResponse(message);
  }

  void _botResponse(String message) {
    Future.delayed(Duration(milliseconds: 500), () {
      String response = "";
      List<dynamic>? options;

      if (message.toLowerCase() == "hi") {
        response = "Hi Sadiq! Welcome to the SwiftClean Help Center.";
        response = "How can I help you today?";
        options = ["My Bookings", "Cancel Booking", "Payment", "Something Else"];
      } else if (message == "My Bookings") {
        response = "Here are your bookings:";
        options = [
          {"title": "Garden Cleaning", "image": "assets/image/Gardens.png"},
          {"title": "Exterior Wash", "image": "assets/image/Exterior_wash.png"},
        ];
      } else {
        response = "I didn't understand. Please choose from the options.";
      }

      setState(() {
        _messages.add({
          "sender": "bot",
          "text": response,
          "time": DateTime.now(),
          "options": options,
        });
      });
    });
  }

  String _formattedTime(DateTime time) {
    return DateFormat("hh:mm a").format(time);
  }

  String _getDateHeader(DateTime time) {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));

    if (DateFormat('yyyy-MM-dd').format(time) == DateFormat('yyyy-MM-dd').format(now)) {
      return "Today";
    } else if (DateFormat('yyyy-MM-dd').format(time) == DateFormat('yyyy-MM-dd').format(yesterday)) {
      return "Yesterday";
    } else {
      return DateFormat("dd MMM yyyy").format(time);
    }
  }

  Widget _buildMessage(Map<String, dynamic> message, bool showDateHeader) {
    bool isUser = message["sender"] == "user";

    return Column(
      crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (showDateHeader)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _getDateHeader(message["time"]),
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ),
            ),
          ),
        Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUser ? const Color.fromRGBO(53, 120, 1, 1) : const Color.fromRGBO(241, 255, 239, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: isUser ? Radius.circular(20) : Radius.zero,
                bottomRight: isUser ? Radius.zero : Radius.circular(20),
              ),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
            ),
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message["text"],
                  style: TextStyle(color: isUser ? const Color.fromARGB(255, 255, 255, 255) : Colors.black),
                ),
                SizedBox(height: 5),
                Text(
                  _formattedTime(message["time"]),
                  style: TextStyle(color: isUser ? const Color.fromARGB(255, 255, 255, 255) :  const Color.fromARGB(255, 0, 0, 0), fontSize: 10),
                ),
              ],
            ),
          ),
        ),
        if (message["options"] != null) _buildOptions(message["options"]),
      ],
    );
  }

  Widget _buildOptions(List<dynamic> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        width: 230,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(241, 255, 239, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20)
          ),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          children: options.map((option) {
            if (option is String) {
              return GestureDetector(
                onTap: () => _sendMessage(option),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(option, style: TextStyle(color: Colors.black, fontSize: 16)),
                        Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              );
            } else if (option is Map<String, String>) {
              return GestureDetector(
                onTap: () => _sendMessage(option["title"]!),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
                    ),
                    child: Row(
                      children: [
                        Image.asset(option["image"]!, width: 50, height: 50),
                        SizedBox(width: 10),
                        Expanded(child: Text(option["title"]!, style: TextStyle(fontSize: 16))),
                        Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: Text("Swift Support",
                style: TextStyle(
                  fontSize: 20,color: Colors.white
                ),)),
            ),
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)
              ),
                  gradient: LinearGradient(
                    colors:[
                    Color.fromARGB(255, 102, 214, 10),
                    Color.fromARGB(255, 113, 191, 4),
                    Color.fromARGB(255, 26, 159, 6),
                    ])
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool showDateHeader = index == 0 ||
                    _getDateHeader(_messages[index]["time"]) != _getDateHeader(_messages[index - 1]["time"]);
                return _buildMessage(_messages[index], showDateHeader);
              },
            ),
          ),
          _buildBottomInput(),
        ],
      ),
    );
  }

  Widget _buildBottomInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 110,left: 10),
      child: Row(
        children: [
          Expanded(
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(15),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "How Can I Help You?",
                  hintStyle: TextStyle(color:Colors.grey),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none)
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              width: 60,
              height: 50,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                mini: true,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                onPressed: () => _sendMessage(_controller.text.trim()),
                child: Icon(Icons.send, color: gradientgreen2.c),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
