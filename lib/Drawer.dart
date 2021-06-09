import 'package:ctse/Profile/userprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: <Widget>[
          new UserAccountsDrawerHeader(
              accountName: new Text('TestUser'),
              accountEmail: new Text('test@test.com'),
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
                        builder: (BuildContext context) => new UserProfile()));
              }),
          new ListTile(
              title: new Text("SignOut"),
              leading: Icon(Icons.logout, color: Colors.lightBlue),
              onTap: (){
                FirebaseAuth.instance.signOut();
              }
          ),
        ]));

  }
}