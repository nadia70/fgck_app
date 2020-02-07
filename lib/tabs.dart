import 'package:fgck_app/events.dart';
import 'package:fgck_app/gallery.dart';
import 'package:fgck_app/loginUI/Login.dart';
import 'package:fgck_app/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import 'home.dart';

class tabView extends StatefulWidget {
  @override
  _tabViewState createState() => _tabViewState();
}

class _tabViewState extends State<tabView> with SingleTickerProviderStateMixin {

  TabController controller;
  String _email;
  String id;
  String _password;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', "");
    prefs.setString('dept', "");

    setState(() {
      isLoggedIn = false;
    });

    Navigator.of(context).push(new CupertinoPageRoute(
        builder: (BuildContext context) => new Login()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // Appbar
      appBar: new AppBar(
        title: Text("Full Gospel Church", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            icon: new Icon(Icons.person),
            onSelected: (String value) {
              switch (value) {
                case 'logout':
                  logout();
                  break;
              // Other cases for other menu options
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: "logout",
                child: Row(
                  children: <Widget>[
                    Text("LOGOUT"),
                    Icon(Icons.exit_to_app, color: Colors.deepPurple[900],),
                  ],
                ),
              ),
            ],
          ),
        ]
      ),

      body: new TabBarView(
        // Add tabs as widgets
        children: <Widget>[new Home(),  new events(), new profile(), ],
        // set the controller
        controller: controller,
      ),
      // Set the bottom navigation bar
      bottomNavigationBar: new Material(
        // set the color of the bottom navigation bar
        color: Colors.deepPurple[900],
        // set the tab bar as the child of bottom navigation bar
        child: new TabBar(
          tabs: <Tab>[
            new Tab(
              // set icon to the tab
              icon: new Icon(Icons.home),
            ),
            new Tab(
              icon: new Icon(Icons.calendar_today),
            ),

            new Tab(
              icon: new Icon(Icons.person),
            ),
          ],
          // setup the controller
          controller: controller,
        ),
      ),
    );
  }
}
