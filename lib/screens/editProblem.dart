import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:ctse/models/problem.dart';
import 'package:ctse/screens/showAddProblem.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProblem extends StatefulWidget {
  final String id;
  final String age;
  final String mStatus;
  final String occupation;
  final String problem;

  const EditProblem(
      {Key key,
       this.id,
       this.age,
       this.mStatus,
       this.occupation,
       this.problem})
      : super(key: key);

  @override
  _EditProblemState createState() =>
      _EditProblemState(id, age, mStatus, occupation, problem);
}

class _EditProblemState extends State<EditProblem> {
  final String id;
  final String age;
  final String mStatus;
  final String occupation;
  final String problem;

  _EditProblemState(
      this.id, this.age, this.mStatus, this.occupation, this.problem);

  @override
  void initState() {
    // _refreshOrderList();
    // TODO: implement initState
    super.initState();
  }

  Future<http.Response> updateQuestion(
      String age, String mStatus, String occupation, String problem) {
    return http.put(
      Uri.parse('https://ctsebe.herokuapp.com/question/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'age': age,
        'mStatus': mStatus,
        'occupation': occupation,
        'problem': problem
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(problem);
    final ageController = TextEditingController(text: age);
    final mStatusController = TextEditingController(text: mStatus);
    final occupationController = TextEditingController(text: occupation);
    final problemController = TextEditingController(text: problem);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Problem"),
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
                      labelText: "Married Status",
                      prefixIcon: Icon(Icons.api_rounded),
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
                      labelText: "Occupation",
                      prefixIcon: Icon(Icons.work),
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
                  onChanged: (String problem) {
                    // getAge(problem);
                  },
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
                        text: "Your Question was successful Updated!",
                      );
                      var response = updateQuestion(
                              ageController.text,
                              mStatusController.text,
                              occupationController.text,
                              problemController.text)
                          .then((result) {
                        if (result.statusCode == 200) {
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
                            text: "Your Question was Not Updated!",
                          );
                        }
                      });
                    },
                    child: Text("Update"),
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
