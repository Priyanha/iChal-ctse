import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctse/Profile/userprofile.dart';
import 'package:ctse/screens/showAddProblem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {

  String name;
  String uid;
  String email;
  String password;
  String age;
  String status;
  String career;

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .get()
          .then((ds) {
        name = ds.get('name');
        email = ds.get('email');
        password = ds.get('password');
        age = ds.get('age');
        career = ds.get('career');
        status = ds.get('status');
        // print(name);
      }).catchError((e) {
        print(e);
      });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return Text("");
          return Drawer(
              child: ListView(children: <Widget>[
                new UserAccountsDrawerHeader(
                    accountName: new Text('$name'),
                    accountEmail: new Text('$email'),
                    currentAccountPicture: new CircleAvatar(
                      child: Image.asset('images/icon.jpg'),
                    )),
                new ListTile(
                    title: new Text("User Profile"),
                    leading: Icon(Icons.person, color: Colors.lightBlue),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (
                                  BuildContext context) => new UserProfile()));
                    }),
                new ListTile(
                    title: new Text("Challenges"),
                    leading: Icon(Icons.logout, color: Colors.lightBlue),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (
                                  BuildContext context) => new ShowAddProblem()));
                    }
                ),
                new ListTile(
                    title: new Text("SignOut"),
                    leading: Icon(Icons.logout, color: Colors.lightBlue),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    }
                ),
              ]));
        });

  }
}