import 'package:chatapp/services/chat/chat_service.dart';
import 'package:chatapp/widgets/custom_chat_bubble.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String receiverID;
  final String receiverEmail;
  ChatScreen({
    super.key,
    required this.receiverID,
    required this.receiverEmail,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  ChatService chatService = ChatService();

  ScrollController scrollController = ScrollController();

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  FocusNode focusNode = FocusNode();
  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(
        messageController.text,
        widget.receiverID,
      );
      messageController.clear();
    }
    scrollDown();
  }

  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(
          Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });
    Future.delayed(
      Duration(milliseconds: 500),
      () => scrollDown(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: Text(widget.receiverEmail),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: chatService.getMessage(
                firebaseAuth.currentUser!.uid,
                widget.receiverID,
              ),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error : ${snapshot.error}"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.grey,
                  ));
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text("No data available"));
                }
                List<DocumentSnapshot> messages = snapshot.data!.docs;

                return ListView.builder(
                  controller: scrollController,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot message = messages[index];
                    String msg = message['message'];
                    String senderId = message['senderID'];
                    bool isCurrentUser =
                        senderId == firebaseAuth.currentUser!.uid;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: Container(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: CustomChatBubble(
                          msg: msg,
                          color: isCurrentUser
                              ? Colors.green
                              : Colors.grey.shade400,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    focusNode: focusNode,
                    controller: messageController,
                    hintText: 'Enter message',
                  ),
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: sendMessage,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
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
