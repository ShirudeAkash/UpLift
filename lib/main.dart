import 'package:firebase_app/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        backgroundColor: Colors.yellow[200],
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        // textButtonTheme: TextButtonThemeData.from(context).copyWith(
        //   buttonColor: Colors.pink,
        //   textTheme: ButtonTextTheme.primary,
        //   shape : RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        // ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return ChatScreen();
            }
            return AuthScreen();
          }),
    );
  }
}
