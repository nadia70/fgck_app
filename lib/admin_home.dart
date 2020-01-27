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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video list"),
        backgroundColor: Colors.deepPurple[900],),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            StreamBuilder<Object>(
              stream: null,
              builder: (context, snapshot) {
                return FutureBuilder(
                    future: getList(),
                    builder: (context, snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading... Please wait"),
                        );
                      }if (snapshot.data == null){
                        return Center(
                          child: Text("The are no Videos"),);
                      }else{
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Image.network(snapshot.data[index].data["thumbNail"]),
                              title: Text("${snapshot.data[index].data["Title"]}"),
                              subtitle: Text("${snapshot.data[index].data["preacher"]}"),
                              trailing: RaisedButton(
                                color: Colors.deepPurple[900],
                                  onPressed: () async {
                                    await
                                    collectionReference
                                        .document(snapshot.data[index].documentID)
                                        .delete();

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Deleted"),
                                            content: Text("Removed from Cart"),
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
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text('Delete',style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                              ),
                            );

                          },
                        );

                      }
                    });
              }
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
