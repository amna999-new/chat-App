import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/widgets/custom_user_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void logout() async {
    AuthService authService = AuthService();
    await authService.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.grey.shade300,
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.message,
                size: 100,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Icon(Icons.home),
                title: Text('H O M E'),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 25, bottom: 25),
              child: ListTile(
                onTap: logout,
                leading: Icon(Icons.logout),
                title: Text('L O G O U T'),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: Text(
          _firebaseAuth.currentUser!.email.toString(),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _firestore.collection("users").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          List<DocumentSnapshot> users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext conetxt, int index) {
              DocumentSnapshot user = users[index];
              String uid = user['uid'];
              String email = user['email'];
              if (email != _firebaseAuth.currentUser!.email) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 15,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            receiverID: uid,
                            receiverEmail: email,
                          ),
                        ),
                      );
                    },
                    child: CustomUserTile(
                      email: email,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }
}
