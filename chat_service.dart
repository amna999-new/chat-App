import 'package:chatapp/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseAuth firebase_auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String message, String receiverID) async {
    final String senderID = firebase_auth.currentUser!.uid;
    final String senderEmail = firebase_auth.currentUser!.email!;
    Timestamp timestamp = Timestamp.now();
    MessageModel messageModel = MessageModel(
      message: message,
      receiverID: receiverID,
      senderID: senderID,
      senderEmail: senderEmail,
      timestamp: timestamp,
    );
    List<String> ids = [senderID, receiverID];
    ids.sort();
    String chatRoomID = ids.join("_");
    _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(messageModel.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
