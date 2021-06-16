import 'package:flutter/material.dart';

class ProblemDetails extends StatefulWidget {
  const ProblemDetails({Key key}) : super(key: key);

  @override
  _ProblemDetailsState createState() => _ProblemDetailsState();
}

class _ProblemDetailsState extends State<ProblemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Problem"),
      ),
    );
  }
}
