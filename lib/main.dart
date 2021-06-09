import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ctse/Login.dart';
import 'package:ctse/SignUp.dart';
import 'package:ctse/Start.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   runApp(MyApp());
   }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primaryColor: Colors.lightBlue
      ),
      debugShowCheckedModeBanner: false,
      home:
      // HomePage(),
        AnimatedSplashScreen(
        splash: Image.asset('images/logo.png'),
        splashIconSize: 200.0,
        nextScreen:  HomePage(),
        splashTransition: SplashTransition.scaleTransition,
        duration: 3000,
      ),


      routes: <String,WidgetBuilder>{

        "Login" : (BuildContext context)=>Login(),
        "SignUp":(BuildContext context)=>SignUp(),
        "start":(BuildContext context)=>Start(),
        "home":(BuildContext context)=>HomePage(),
      },
      
    );
  }

}



