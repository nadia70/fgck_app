import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fgck_app/video_list_item.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future getVideo() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("videos").getDocuments();
    return qn.documents;
  }

  Future getNew() async{
    var firestore = Firestore.instance;
    QuerySnapshot snap = await firestore.collection("videos").orderBy('time').limit(1).getDocuments();
    return snap.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[

        new Flexible(
        child: FutureBuilder(
            future: getNew(),
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
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("Newest upload",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                                color: Colors.black),),
                          ChewieListItem(
                            videoPlayerController: VideoPlayerController.network(
                              snapshot.data[index].data["video"],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );

                },
              );

            }
          }),),
            new Flexible(
              child: FutureBuilder(
                  future: getVideo(),
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
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              new Card(
                                child: Stack(
                                  alignment: FractionalOffset.topLeft,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ChewieListItem(
                                            videoPlayerController: VideoPlayerController.network(
                                                snapshot.data[index].data["video"],
                                            ),
                                          ),
                                        ),

                                        new Container(
                                          height:35.0 ,
                                          color: Colors.white,
                                          child: new Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: new Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                new Text("${snapshot.data[index].data["Title"]}",
                                                  style: new TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12.0,
                                                      color: Colors.black),),
                                                new Text("by.${snapshot.data[index].data["preacher"]}",
                                                  style: new TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400),),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    new SizedBox(
                                      height: 10.0,
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          );

                        },
                      );

                    }
                  }),)
          ],
        ),
      )

    );
  }
}