import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/widgets/button_field.dart';
import 'package:chatapp/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({
    super.key,
  });

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  void forgetPassword() async {
    AuthService authService = AuthService();
    try {
      await authService.forgetPassword(emailController.text);
      emailController.clear();
      Fluttertoast.showToast(msg: 'Password reset link sent!');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.message,
                  size: 100,
                  color: Colors.blue,
                ),
                SizedBox(height: 50),
                Text(
                  "Enter your email to reset password!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 25),
                CustomTextfield(
                  mycontroller: emailController,
                  hintText: 'Email',
                ),
                SizedBox(height: 10),
                CustomButton(
                  text: 'Reset password',
                  onTap: forgetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
