import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final FocusNode? focusNote;
  final TextEditingController mycontroller;
  final Widget? safixIcon;
  final bool? obscureText;
  final String hintText;
  const CustomTextfield({
    super.key,
    required this.mycontroller,
    required this.hintText,
    this.obscureText,
    this.safixIcon,
    this.focusNote,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNote,
      obscureText: obscureText ?? false,
      controller: mycontroller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        suffixIcon: safixIcon,
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.lightBlue,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
