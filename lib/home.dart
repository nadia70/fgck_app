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
    QuerySnapshot qn = await firestore.collection("trucks").getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
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
                        child: Text("The are no pending requests"),);
                    }else{
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return new Card(
                            child: Stack(
                              alignment: FractionalOffset.topLeft,
                              children: <Widget>[
                                ChewieListItem(
                                  videoPlayerController: VideoPlayerController.network(
                                      snapshot.data[index].data["video"],
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
                                              color: Colors.white),),
                                        new Text("by.${snapshot.data[index].data["preacher"]}",
                                          style: new TextStyle(
                                              color: Colors.red[500],
                                              fontWeight: FontWeight.w400),),
                                      ],
                                    ),
                                  ),
                                )

                              ],
                            ),
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