import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:ctse/main.dart';
import 'package:ctse/screens/showAddProblem.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';

class AddProblem extends StatefulWidget {
  const AddProblem({Key key}) : super(key: key);

  @override
  _AddProblemState createState() => _AddProblemState();
}

class _AddProblemState extends State<AddProblem> {
  final ageController = TextEditingController();
  final mStatusController = TextEditingController();
  final occupationController = TextEditingController();
  final problemController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    // myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    ageController.dispose();
    mStatusController.dispose();
    occupationController.dispose();
    problemController.dispose();
    super.dispose();
  }

  Future<http.Response> createQuestion() {
    return http.post(
      Uri.parse('https://ctsebe.herokuapp.com/question'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'age': ageController.text,
        "mStatus": mStatusController.text,
        "occupation": occupationController.text,
        "problem": problemController.text
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ADD PROBLEM",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 500,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.battery_alert),
                      labelText: "Age",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2))),
                  onChanged: (String age) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: mStatusController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.api_rounded),
                      labelText: "Married Status",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2))),
                  onChanged: (String mStatus) {
                    // getMStatus(mStatus);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: occupationController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.work),
                      labelText: "Occupation",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2))),
                  onChanged: (String occupation) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: problemController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.sync_problem),
                      labelText: "Problem",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2))),
                  onChanged: (String problem) {},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)))),
                    onPressed: () {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.success,
                        text: "Your Problem was successful Added!",
                      );
                      createQuestion().then((result) {
                        print(result.statusCode);
                        if (result.statusCode == 201) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowAddProblem()),
                            (Route<dynamic> route) => false,
                          );
                        } else {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            text: "Your Problem was not Created!",
                          );
                        }
                      });
                      //
                    },
                    child: Text("Add"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
