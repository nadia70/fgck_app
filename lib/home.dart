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
    QuerySnapshot qn = await firestore.collection("videos").orderBy('time').getDocuments();
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
                          new SizedBox(
                            height: 10.0,
                          ),
                          Text("Newest Video", style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.black),),

                          new GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new videoDetail(

                                itemImage: snapshot.data[index].data["thumbNail"][0],
                                itemName: snapshot.data[index].data["Title"],
                                itemPreacher: snapshot.data[index].data["preacher"],
                                itemRating: snapshot.data[index].data["productRating"],
                                itemDescription: snapshot.data[index].data["productDesc"],
                                index: index,


                              )));
                            },
                            child: new Card(
                              child: Stack(
                                alignment: FractionalOffset.topLeft,
                                children: <Widget>[
                                  new Stack(
                                    alignment: FractionalOffset.bottomCenter,
                                    children: <Widget>[
                                      new Container(
                                        decoration: new BoxDecoration(
                                            image: new DecorationImage(
                                                fit: BoxFit.fitWidth ,
                                                image: new NetworkImage(snapshot.data[index].data["thumbNail"]))
                                        ),

                                      ),
                                      new Container(
                                        height:35.0 ,
                                        color: Colors.black.withAlpha(100),
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
                                              new Text("by:${snapshot.data[index].data["preacher"]}",
                                                style: new TextStyle(
                                                    color: Colors.red[500],
                                                    fontWeight: FontWeight.w400),),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                ],
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
                                        fontSize: 18.0,
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
                  );

                },
              );

            }
          }),),

          ],
        ),
      )

    );
  }
}


class videoDetail extends StatefulWidget {
  String itemName;
  String itemPreacher;
  String itemSubName;
  String itemImage;
  String itemRating;
  String itemDescription;
  final index;

  videoDetail({

    this.itemName,
    this.itemPreacher,
    this.itemSubName,
    this.itemImage,
    this.itemRating,
    this.itemDescription,
    this.index
  });


  @override
  _videoDetailState createState() => _videoDetailState();
}

class _videoDetailState extends State<videoDetail> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
