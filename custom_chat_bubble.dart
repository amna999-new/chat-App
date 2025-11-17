import 'package:flutter/material.dart';

class CustomChatBubble extends StatelessWidget {
  final Color color;
  final String msg;
  const CustomChatBubble({
    super.key,
    required this.msg,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          msg,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
