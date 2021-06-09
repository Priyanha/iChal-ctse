import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdatePro extends StatefulWidget {
  @override
  _UpdateProState createState() => _UpdateProState();
}

class _UpdateProState extends State<UpdatePro> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String uid, _name, _email, _password, _age, _status, _career;
  String name, email, password, age, status, career;

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController statusController = new TextEditingController();
  TextEditingController careerController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetch();
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

        nameController.text = '$name';
        emailController.text = '$email';
        passwordController.text = '$password';
        ageController.text = '$age';
        careerController.text = '$career';
        statusController.text = '$status';
        // print(name);
      }
      ).catchError((e) {
        print(e);
      });
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  child: Image(
                    image: AssetImage("images/login.jpg"),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  child: FutureBuilder(
                future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text("Loading data...Please wait");
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0,
                                  right: 15.0,
                                  top: 8.0,
                                  bottom: 8.0),
                              child: TextFormField(
                                validator: (input) {
                                  if (input.isEmpty) return 'Enter Name';
                                },
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  prefixIcon: Icon(Icons.person),
                                ),
                                onSaved: (input) => _name = input,
                                controller: nameController,
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0,
                                  right: 15.0,
                                  top: 8.0,
                                  bottom: 8.0),
                              child: TextFormField(
                                validator: (input) {
                                  if (input.isEmpty) return 'Enter Your Age';
                                },
                                decoration: InputDecoration(
                                  labelText: 'Age',
                                  prefixIcon: Icon(Icons.format_list_numbered),
                                ),
                                onSaved: (input) => _age = input,
                                controller: ageController,
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0,
                                  right: 15.0,
                                  top: 8.0,
                                  bottom: 8.0),
                              child: TextFormField(
                                validator: (input) {
                                  if (input.isEmpty)
                                    return 'Enter Civil Status';
                                },
                                decoration: InputDecoration(
                                  labelText: 'Status',
                                  prefixIcon: Icon(Icons.wc_outlined),
                                ),
                                onSaved: (input) => _status = input,
                                controller: statusController,
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0,
                                  right: 15.0,
                                  top: 8.0,
                                  bottom: 8.0),
                              child: TextFormField(
                                validator: (input) {
                                  if (input.isEmpty) return 'Enter Employment';
                                },
                                decoration: InputDecoration(
                                  labelText: 'Career',
                                  prefixIcon: Icon(Icons.youtube_searched_for),
                                ),
                                onSaved: (input) => _career = input,
                                controller: careerController,
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0,
                                  right: 15.0,
                                  top: 8.0,
                                  bottom: 8.0),
                              child: TextFormField(
                                validator: (input) {
                                  if (input.isEmpty) return 'Enter Email';
                                },
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.email)),
                                onSaved: (input) => _email = input,
                                controller: emailController,
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0,
                                  right: 15.0,
                                  top: 8.0,
                                  bottom: 8.0),
                              child: TextFormField(
                                validator: (input) {
                                  if (input.length < 6)
                                    return 'Provide Minimum 6 Character';
                                },
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                ),
                                obscureText: true,
                                onSaved: (input) => _password = input,
                                controller: passwordController,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                            onPressed: () {
                              _update();

                              // Updae Firestore record information regular way

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
                          SizedBox(height: 20),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ));
  }

  _update() async {
    Map<String, dynamic> updateUser = new Map<String,dynamic>();
    updateUser["name"] = nameController.text;
    updateUser["email"] = emailController.text;
    updateUser["password"] = passwordController.text;
    updateUser["age"] = ageController.text;
    updateUser["status"] = statusController.text;
    updateUser["career"] = careerController.text;

    final firebaseUser = await FirebaseAuth.instance.currentUser;
    Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .updateData(updateUser)
        .whenComplete((){
      Navigator.of(context).pop();
    });
  }

}
