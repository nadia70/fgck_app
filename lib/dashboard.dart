import 'package:fgck_app/addEvents.dart';
import 'package:fgck_app/admin.dart';
import 'package:fgck_app/admin_home.dart';
import 'package:fgck_app/appUsers.dart';
import 'package:fgck_app/events.dart';
import 'package:fgck_app/fade_route_builder.dart';
import 'package:fgck_app/loginUI/Login.dart';
import 'package:fgck_app/loginUI/bacground.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isLoggedIn = false;

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
    return Scaffold(

      body: Column(
        children: <Widget>[
          new Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              WavyHeader(),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Text("Admin",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 54.0),
                    textAlign: TextAlign.center),
              ),
              Positioned(
                top: 40,
                left: 300,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        PopupMenuButton(
                          icon: new Icon(Icons.person, color: Colors.white,),
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                padding: EdgeInsets.all(16.0),
                childAspectRatio: 9.0 / 9.0,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(FadeRouteBuilder(page: new appUsers()));
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AspectRatio(
                              aspectRatio: 18.0 / 11.0,
                              child: Icon(Icons.group, size: 50.0, color: Colors.deepPurple[900],)
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('APP USERS', style: TextStyle(color: Colors.deepPurple[900], fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(FadeRouteBuilder(page: new EventsList()));
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AspectRatio(
                              aspectRatio: 18.0 / 11.0,
                              child: Icon(Icons.assignment, size: 50.0, color: Colors.deepPurple[900],)
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Events', style: TextStyle(color: Colors.deepPurple[900], fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(FadeRouteBuilder(page: new adminHome()));
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AspectRatio(
                              aspectRatio: 18.0 / 11.0,
                              child: Icon(Icons.video_library, size: 50.0, color: Colors.deepPurple[900],)
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Videos', style: TextStyle(color: Colors.deepPurple[900], fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(FadeRouteBuilder(page: new Admin()));
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AspectRatio(
                              aspectRatio: 18.0 / 11.0,
                              child: Icon(Icons.add, size: 50.0, color: Colors.deepPurple[900],)
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('New video', style: TextStyle(color: Colors.deepPurple[900], fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                ],// Replace
            ),
          )
        ],
      ),
    );
  }
}

class _GridItemWidget extends StatelessWidget {
  final GridItem gridItem;

  _GridItemWidget(this.gridItem);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(FadeRouteBuilder(page: gridItem.widgetScreen)),
      child: GridTile(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.shortestSide * 0.025),
          child: new Material(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.shortestSide * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(
                      flex: 5,
                    ),
                    Hero(
                      tag: gridItem.title,
                      child: Text(
                        gridItem.title,
                        style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide * 0.04),
                      ),
                    ),
                    Spacer(
                      flex: 5,
                    ),
                    Icon(
                      gridItem.icon,
                      size: MediaQuery.of(context).size.height * 0.05,
                      color: Colors.white,
                    ),
                    Spacer(
                      flex: 5,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height * 0.75);
    path.quadraticBezierTo(
      size.width / 4,
      size.height,
      size.width / 2,
      size.height,
    );
    path.quadraticBezierTo(
      size.width - (size.width / 4),
      size.height,
      size.width,
      size.height * 0.75,
    );
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class GridItem {
  final List<Color> colorList;
  final IconData icon;
  final String title;
  final Widget widgetScreen;

  GridItem(this.colorList, this.icon, this.title, this.widgetScreen);
}