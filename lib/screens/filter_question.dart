import 'package:ctse/models/problem.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FilterQuestion extends StatefulWidget {
  const FilterQuestion({Key key}) : super(key: key);

  @override
  _FilterQuestionState createState() => _FilterQuestionState();
}

class _FilterQuestionState extends State<FilterQuestion> {
  List problems = [];

  Future<List<Problem>> getProblems(String age, String occuption) async {
    var response = await Dio().get(
        'https://ctsebe.herokuapp.com/question?age=$age&occupation=$occuption');
    return (response.data['data'] as List)
        .map<Problem>((json) => Problem.fromJson(json))
        .toList();
  }

  _refreshOrderList() async {
    List x = await getProblems(ageController.text, occupationController.text);
    setState(() {
      problems = x;
    });
  }

  @override
  void initState() {
    // getProblems();

    // TODO: implement initState
    print(problems);
    super.initState();
  }

  final ageController = TextEditingController();
  // final mStatusController = TextEditingController();
  final occupationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Question"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                      labelText: "Age",
                      prefixIcon: Icon(Icons.battery_alert),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2))),
                  onChanged: (String age) {},
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(16.0),
              //   child: TextFormField(
              //     controller: mStatusController,
              //     decoration: InputDecoration(
              //         prefixIcon: Icon(Icons.api_rounded),
              //         labelText: "Married Status",
              //         fillColor: Colors.white,
              //         focusedBorder: OutlineInputBorder(
              //             borderSide:
              //                 BorderSide(color: Colors.blue, width: 2))),
              //     onChanged: (String mStatus) {
              //       // getMStatus(mStatus);
              //     },
              //   ),
              // ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)))),
                    onPressed: () {
                      //
                      EasyLoading.show(status: 'loading...');
                      _refreshOrderList();

                      EasyLoading.dismiss();
                    },
                    child: Text("Search"),
                  )
                ],
              ),
              Container(
                height: 400,
                child: Scaffold(
                  body: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Divider(
                          height: 2,
                          thickness: 3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Result",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("AGE: " + ageController.text),
                                  // Text("STATUS: " + mStatusController.text),
                                  Text("OCCUPATION: " +
                                      occupationController.text)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 2,
                        thickness: 3,
                      ),
                      SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.donut_large,
                                        color: Colors.deepPurpleAccent,
                                        size: 20.0,
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                    problems[index].problem,
                                    style: TextStyle(
                                        // color: Constant.darkBlueColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      "Status : " + problems[index].mStatus),
                                  onTap: () {},
                                ),
                                Divider(
                                  height: 5.0,
                                ),
                              ],
                            );
                          },
                          itemCount: problems.length,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
