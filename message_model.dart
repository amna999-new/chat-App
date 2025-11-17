import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String senderID;
  final String receiverID;
  final String senderEmail;
  final Timestamp timestamp;

  MessageModel({
    required this.message,
    required this.receiverID,
    required this.senderID,
    required this.senderEmail,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'message' : message,
      'senderID' : senderID,
      'receiverID' : receiverID,
      'senderEmail' : senderEmail,
      'timestamp' : timestamp,
    };
  }
}
