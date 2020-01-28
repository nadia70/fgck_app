import 'package:fgck_app/events.dart';
import 'package:fgck_app/gallery.dart';
import 'package:fgck_app/profile.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'home.dart';

class tabView extends StatefulWidget {
  @override
  _tabViewState createState() => _tabViewState();
}

class _tabViewState extends State<tabView> with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
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
          new IconButton(
            icon: new Image.asset('assets/fgck.png'),
            onPressed: () {},
          )
        ]

      ),

      body: new TabBarView(
        // Add tabs as widgets
        children: <Widget>[new Home(),  new events(), new Gallery(), new profile(), ],
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
              icon: new Icon(Icons.photo_library),
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
