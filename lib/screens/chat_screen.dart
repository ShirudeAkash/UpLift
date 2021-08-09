import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UpLift'),
        shadowColor: Colors.yellow,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/5B5VzkQmbfiJp4vFYYvm/messages')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = streamSnapshot.data!.docs;
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[index]['text']),
            ),
          );
        },
      ),
      drawer: Drawer(
          child: Container(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/dheader.png"),
                      fit: BoxFit.cover)),
              child: Align(
                child: Text(
                  'Hi Akash,Nice to see you here',
                ),
                alignment: Alignment.bottomRight,
              ),
            ),
            Divider(
              height: 50,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.space_dashboard),
                  SizedBox(width: 8),
                  Text('Dashboard'),
                ],
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.moving_sharp),
                  SizedBox(width: 8),
                  Text('Progress'),
                ],
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 50,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.add_box_rounded),
                  SizedBox(width: 8),
                  Text('Add a Program'),
                ],
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.next_plan_outlined),
                  SizedBox(width: 8),
                  Text('Personalized Plan'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 50,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.settings),
                  SizedBox(width: 8),
                  Text('Settings'),
                ],
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.exit_to_app),
                  SizedBox(width: 8),
                  Text('Log Out'),
                ],
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // FirebaseFirestore.instance
          //     .collection('chats/5B5VzkQmbfiJp4vFYYvm/messages')
          //     .add({'text': 'This was Added by clicking but'});
        },
      ),
    );
  }
}
