import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupScreen extends StatefulWidget {
  final void Function() onPressed;
  const SignupScreen({super.key, required this.onPressed});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool toHidePassword = true;
  bool toHideConfirmPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  void signup() async {
    if (passwordController.text == confirmPasswordController.text) {
      AuthService authService = AuthService();
      try {
        await authService.signup(
          emailController.text,
          passwordController.text,
        );
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      Fluttertoast.showToast(msg: "Passwords do not match!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  color: Colors.grey,
                ),
                SizedBox(height: 50),
                Text(
                  "Let's create an account for you!",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 25),
                CustomTextfield(
                  controller: emailController,
                  hintText: 'Email',
                ),
                SizedBox(height: 10),
                CustomTextfield(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        toHidePassword = !toHidePassword;
                      });
                    },
                    icon: Icon(
                      toHidePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                  obscureText: toHidePassword,
                  controller: passwordController,
                  hintText: 'Password',
                ),
                SizedBox(height: 10),
                CustomTextfield(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        toHideConfirmPassword = !toHideConfirmPassword;
                      });
                    },
                    icon: Icon(
                      toHideConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                  obscureText: toHideConfirmPassword,
                  controller: confirmPasswordController,
                  hintText: 'Confirm password',
                ),
                SizedBox(height: 25),
                CustomButton(
                  text: 'Singup',
                  onTap: signup,
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: widget.onPressed,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
