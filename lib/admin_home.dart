import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

import 'admin.dart';

class adminHome extends StatefulWidget {
  @override
  _adminHomeState createState() => _adminHomeState();
}

class _adminHomeState extends State<adminHome> {

  Future getList() async{
    var firestore = Firestore.instance;
    QuerySnapshot snap = await firestore.collection("videos").orderBy('time', descending: true).getDocuments();
    return snap.documents;
  }

  CollectionReference collectionReference =
  Firestore.instance.collection("videos");
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video list"),
        backgroundColor: Colors.deepPurple[900],),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(12.0),
              children: <Widget>[
                SizedBox(height: 20.0),
                StreamBuilder<QuerySnapshot>(
                    stream: db.collection('videos').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data.documents.map((doc) {
                            return ListTile(
                              leading: Image.network(doc.data["thumbNail"]),
                              title: Text("${doc.data["Title"]}"),
                              subtitle: Text("${doc.data["preacher"]}"),
                              trailing: RaisedButton(
                                color: Colors.deepPurple[900],
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Delete this video"),
                                          content: Text("Are you sure??"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("Yes"),
                                              onPressed: () async {
                                                await db
                                                    .collection('videos')
                                                    .document(doc.documentID)
                                                    .delete();

                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text("Deleted"),
                                                        content: Text("Stand deleted from database"),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child: Text("Close"),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("No"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      });

                                },
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text('Delete',style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return SizedBox();
                      }
                    }),
              ],
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add New"),
        backgroundColor: Colors.deepPurple[900],
        onPressed: (){
        Navigator.of(context).push(new CupertinoPageRoute(
            builder: (BuildContext context) => new  Admin()
        )
        );
      },
      ),
    );
  }
}
