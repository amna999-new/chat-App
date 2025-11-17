import 'package:flutter/material.dart';

class CustomUserTile extends StatelessWidget {
  final String email;
  const CustomUserTile({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(30),
        child: Row(
          children: [
            Icon(
              Icons.person,
              color: Colors.grey,
            ),
            SizedBox(width: 15),
            Text(
              email,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
