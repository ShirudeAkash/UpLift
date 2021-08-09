import 'package:firebase_app/widgets/auth/auth_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  // const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false;

  void submitAuthForm(String email, String password, String username,
      bool isLogin, BuildContext ctx) async {
    UserCredential authResult;
    try {
      isLoading = true;
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
        });
      }
    } on PlatformException catch (err) {
      print(err);
      setState(() {
        isLoading = false;
      });
    } catch (err) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text('Enter valid Credentials'),
          // duration: Duration(seconds: 2),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitAuthForm, isLoading),
    );
  }
}
