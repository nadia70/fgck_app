import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _name;
  String _uid;
  String _pw;
  String _dept;
  String Name;
  String uid;
  String ID;
  String userId;
  String pass;
  final db = Firestore.instance;

  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getString('user');
      pass = prefs.getString('pass');
      ID = prefs.getString('ID');
    });

  }

  void _submitCommand() {
    //get state of our Form
    final form = formKey.currentState;

    //`validate()` validates every FormField that is a descendant of this Form,
    // and returns true if there are no errors.
    if (form.validate()) {
      //`save()` Saves every FormField that is a descendant of this Form.
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _updateData();
    }
  }

  _updateData() async {
    await Firestore.instance
        .collection('users')
        .document(ID)
        .updateData({
      'name': _name,
      'pw': _pw,

    }).then((result) =>

        _showPopUp());
  }

  void _showPopUp() {
    // flutter defined function
    final form = formKey.currentState;
    form.reset();
    var context;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text("Your request has been sent"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // background image and bottom contents
          Column(
            children: <Widget>[
              Container(
                height: 200.0,
                color: Colors.deepPurple[900],

              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Text("Logged in As:"),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                              child: Container(
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'SFUIDisplay'
                                  ),
                                  decoration: InputDecoration(
                                      errorStyle: TextStyle(color: Colors.red),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.1),
                                      labelText: 'Name',
                                      labelStyle: TextStyle(
                                          fontSize: 11
                                      )
                                  ),
                                  initialValue: userId,
                                  validator: (val) =>
                                  val.isEmpty  ? null : null,
                                  onSaved: (val) => _name = val,
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                              child: Container(
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'SFUIDisplay'
                                  ),
                                  decoration: InputDecoration(
                                      errorStyle: TextStyle(color: Colors.red),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.1),
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                          fontSize: 11
                                      )
                                  ),
                                  initialValue: pass,
                                  validator: (val) =>
                                  val.isEmpty  ? null : null,
                                  onSaved: (val) => _pw = val,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(70, 10, 70, 0),
                              child: MaterialButton(
                                onPressed: _submitCommand,
                                child: Text('Edit',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'SFUIDisplay',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                color: Colors.white,
                                elevation: 16.0,
                                minWidth: 400,
                                height: 50,
                                textColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                              ),
                            ),




                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          // Profile image
          Positioned(
            top: 150.0, // (background container size) - (circle height / 2)
            child: Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
              ),

              child: Icon (Icons.person),
            ),
          )
        ],
      ),
    );
  }
}

