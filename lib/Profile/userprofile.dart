
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctse/Login.dart';
import 'package:ctse/Profile/updatepro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String name;
  String uid;
  String email;
  String password;
  String age;
  String status;
  String career;

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController statusController = new TextEditingController();
  TextEditingController careerController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Center(child: Text("USER PROFILE",style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w900),)),
        actions: [
          FlatButton.icon(
              onPressed: () {
                _delete();
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Login()));
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              label: Text(
                '',
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ))
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: FutureBuilder(
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Text("Loading data...Please wait");
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40.0),
                      Container(
                        height: 300,
                        child: Image(
                          image: AssetImage("images/welcome.jpg"),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            shadowColor: Colors.blueGrey,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0, left: 25.0, right: 15.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 10.0,),
                                  SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 40.0, left: 40.0, right: 20.0),
                                          child: Center(
                                            child: SingleChildScrollView(
                                              physics: BouncingScrollPhysics(),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15.0),
                                                  Text(
                                                    "NAME : ",
                                                    style:
                                                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 15.0),
                                                  Text(
                                                    "EMAIL : ",
                                                    style:
                                                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 15.0),
                                                  Text(
                                                    "PASSWORD : ",
                                                    style:
                                                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 15.0),
                                                  Text(
                                                    "AGE : ",
                                                    style:
                                                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 15.0),
                                                  Text(
                                                    "STATUS : ",
                                                    style:
                                                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 15.0),
                                                  Text(
                                                    "CAREER : ",
                                                    style:
                                                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 40.0, right: 20.0),
                                          child: Center(
                                            child: SingleChildScrollView(
                                              physics: BouncingScrollPhysics(),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15.0),
                                                  Text(
                                                    "$name",
                                                    style:
                                                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                                                  ),
                                                  SizedBox(height: 15.0),
                                                  Text(
                                                    "$email",
                                                    style:
                                                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                                                  ),
                                                  SizedBox(height: 15.0),
                                                  Text(
                                                    "$password",
                                                    style:
                                                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                                                  ),
                                                  SizedBox(height: 15.0),
                                                  Text(
                                                    "$age",
                                                    style:
                                                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                                                  ),
                                                  SizedBox(height: 15.0),
                                                  Text(
                                                    "$status",
                                                    style:
                                                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                                                  ),
                                                  SizedBox(height: 15.0),
                                                  Text(
                                                    "$career",
                                                    style:
                                                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RaisedButton(
                                    padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                      Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) => new UpdatePro()));
                                      },
                                    child: Text('Update',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                                    color: Colors.lightBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  // SizedBox(height: 30.0,)
                                ],
                              ),
                            ),

                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

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

  _delete() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .delete()
        .catchError((e){
      print(e);
    });
  }
}