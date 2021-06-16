import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctse/models/problem.dart';
import 'package:ctse/screens/addProblem.dart';
import 'package:ctse/screens/editProblem.dart';
import 'package:ctse/screens/filter_question.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:http/http.dart' as http;

class ShowAddProblem extends StatefulWidget {
  const ShowAddProblem({Key key}) : super(key: key);

  @override
  _ShowAddProblemState createState() => _ShowAddProblemState();
}

class _ShowAddProblemState extends State<ShowAddProblem> {
  List problems = [];

  Future<List<Problem>> getProblems() async {
    var response = await Dio().get('https://ctsebe.herokuapp.com/question');
    print(response.data);
    return (response.data['data'] as List)
        .map<Problem>((json) => Problem.fromJson(json))
        .toList();
  }

  _refreshOrderList() async {
    List x = await getProblems();
    setState(() {
      problems = x;
    });
  }

  @override
  void initState() {
    getProblems();
    _refreshOrderList();
    // TODO: implement initState
    print(problems);
    super.initState();
  }

  final db = FirebaseFirestore.instance;

  Future<http.Response> deleteQuestion(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://ctsebe.herokuapp.com/question/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(response.statusCode);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    getProblems();

    return Scaffold(
      appBar: AppBar(
        title: Text("FACING SHOW QUESTIONS"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FilterQuestion()));
              },
            ),
          )
        ],
        leading: Icon(
          Icons.menu,
          size: 40,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProblem()));
        },
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.donut_large,
                      color: Colors.deepPurpleAccent,
                      size: 20.0,
                    ),
                  ],
                ),
                title: Text(
                  problems[index].age,
                  style: TextStyle(
                      // color: Constant.darkBlueColor,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('Status : '),
                            Text(problems[index].mStatus)
                          ],
                        ),
                        Row(
                          children: [
                            Text('Occupation : '),
                            Text(problems[index].occupation)
                          ],
                        ),
                        Text(problems[index].problem)
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditProblem(
                          id: problems[index].id,
                          age: problems[index].age,
                          mStatus: problems[index].mStatus,
                          occupation: problems[index].occupation,
                          problem: problems[index].problem)));
                  // _showForEdit(expenses[index]);
                  // _showMyDialog(list: expenses[index]);
                },
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete_sweep,
                    // color: Constant.darkBlueColor,
                  ),
                  onPressed: () async {
                    if (await confirm(context)) {
                      deleteQuestion(problems[index].id);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowAddProblem()),
                        (Route<dynamic> route) => false,
                      );
                    }
                    return print('pressedCancel');
                  },
                ),
              ),
              Divider(
                height: 5.0,
              ),
            ],
          );
        },
        itemCount: problems.length,
      ),
    );
  }
}
