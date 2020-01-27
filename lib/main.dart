import 'package:fgck_app/admin.dart';
import 'package:fgck_app/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'admin_home.dart';

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
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                Colors.indigo[50],
                Colors.blue[50],
                Colors.indigoAccent,
                Colors.deepPurple[900],
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



              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
                                child: MaterialButton(
                                  onPressed: (){
                                    Navigator.of(context).push(new CupertinoPageRoute(
                                        builder: (BuildContext context) => new Home()
                                    )
                                    );
                                  },
                                  child: Text('Home',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'SFUIDisplay',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  color: Colors.white,
                                  elevation: 16.0,
                                  minWidth: 400,
                                  height: 50,
                                  textColor: Colors.deepPurple[900],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9.0)
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
                                child: MaterialButton(
                                  onPressed: (){
                                    Navigator.of(context).push(new CupertinoPageRoute(
                                        builder: (BuildContext context) => new  adminHome()
                                    )
                                    );
                                  },
                                  child: Text('Admin',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'SFUIDisplay',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  color: Colors.white,
                                  elevation: 16.0,
                                  minWidth: 400,
                                  height: 50,
                                  textColor: Colors.deepPurple[900],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9.0)
                                  ),
                                ),
                              ),
                            )
                          ],
                        )

                    ),
                  ),
                ],
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