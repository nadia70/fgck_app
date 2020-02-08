import 'package:fgck_app/admin.dart';
import 'package:fgck_app/appSignup/baseAuth.dart';
import 'package:fgck_app/appSignup/root.dart';
import 'package:fgck_app/dashboard.dart';
import 'package:fgck_app/home.dart';
import 'package:fgck_app/tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_home.dart';
import 'loginUI/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F.G.C.K APP',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home:  RootPage(auth: new Auth()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _email;
  String id;
  String _password;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('user');
    final String dept = prefs.getString('dept');

    if (dept == "user" && userId != null) {
      Navigator.of(context).push(new CupertinoPageRoute(
          builder: (BuildContext context) => new tabView()
      ));
    }

    if (dept == "admin" && userId != null) {
      Navigator.of(context).push(new CupertinoPageRoute(
          builder: (BuildContext context) => new tabView()
      ));
    }
    else {
      Navigator.of(context).push(new CupertinoPageRoute(
          builder: (BuildContext context) => new Login()
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            // Box decoration takes a gradient
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Colors are easy thanks to Flutter's Colors class.

                Colors.white,
                Colors.white,
              ],
            ),
          ),
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              SizedBox(
                height: 30.0,
              ),

              Text("FULL GOSPEL CHURCH OF KENYA",textAlign: TextAlign.center, style: TextStyle(fontSize: 23.0, letterSpacing: -1.0, wordSpacing: 2.0, ),),

              Image.asset(
                'assets/fgck.png',
                fit: BoxFit.contain,
                height: 200.0,
                width: 200.0,
              ),
              SizedBox(
                height: 10.0,
              ),

              SizedBox(
                height: 30.0,
              ),

            ],
          ),
        ),
      ),
    );
  }
}