import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fgck_app/video_list_item.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseMessaging _messaging = FirebaseMessaging();

  TabController controller;
  Future getVideo() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("videos").orderBy('time').getDocuments();
    return qn.documents;
  }

  Future getNew() async{
    var firestore = Firestore.instance;
    QuerySnapshot snap = await firestore.collection("videos").orderBy('time', descending: true).limit(1).getDocuments();
    return snap.documents;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messaging.subscribeToTopic('sermon');
    _messaging.getToken().then((token) {
      print(token);
    });
    _messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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


                          new GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new videoDetail(

                                itemImage: snapshot.data[index].data["thumbNail"][0],
                                itemName: snapshot.data[index].data["Title"],
                                itemPreacher: snapshot.data[index].data["preacher"],
                                video: snapshot.data[index].data["video"],
                                itemDescription: snapshot.data[index].data["productDesc"],
                                reading1: snapshot.data[index].data["reading1"],
                                reading2: snapshot.data[index].data["reading2"],
                                reading3: snapshot.data[index].data["reading3"],
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
                                        height:250.0 ,
                                        decoration: new BoxDecoration(
                                            image: new DecorationImage(
                                                fit: BoxFit.fitHeight,
                                                image: new NetworkImage(snapshot.data[index].data["thumbNail"]))
                                        ),

                                      ),
                                      new Container(
                                        height:50.0 ,
                                        color: Colors.black.withAlpha(100),
                                        child: new Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  new Text("${snapshot.data[index].data["Title"]}",
                                                    style: new TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 16.0,
                                                        color: Colors.white),),

                                                  new Text("${snapshot.data[index].data["preacher"]}",
                                                    style: new TextStyle(
                                                        color: Colors.red[500],
                                                        fontSize: 12.0,),),
                                                ],
                                              ),

                                              Container(
                                                padding: const EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.white)
                                                ),
                                                child: new Text("NEW",
                                                  style: new TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w400),),
                                              ),

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

            new SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Previous uploads", style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.black),),
                ],
              ),
            ),

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
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  new SizedBox(
                                    height: 10.0,
                                  ),


                                  new GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new videoDetail(

                                        itemImage: snapshot.data[index].data["thumbNail"][0],
                                        itemName: snapshot.data[index].data["Title"],
                                        itemPreacher: snapshot.data[index].data["preacher"],
                                        video: snapshot.data[index].data["video"],
                                        itemDescription: snapshot.data[index].data["productDesc"],
                                        reading1: snapshot.data[index].data["reading1"],
                                        reading2: snapshot.data[index].data["reading2"],
                                        reading3: snapshot.data[index].data["reading3"],
                                        index: index,


                                      )));
                                    },
                                    child: new Card(
                                      elevation:5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Stack(
                                            alignment: FractionalOffset.topLeft,
                                            children: <Widget>[
                                              new Container(
                                                width: MediaQuery.of(context).size.width * 0.6,
                                                height: MediaQuery.of(context).size.height * 0.25,
                                                decoration: new BoxDecoration(
                                                    image: new DecorationImage(
                                                        fit: BoxFit.fitHeight,
                                                        image: new NetworkImage(snapshot.data[index].data["thumbNail"]))
                                                ),

                                              ),

                                            ],
                                          ),
                                          new Container(
                                            height:50.0 ,
                                            color: Colors.white,
                                            child: new Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: new Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[
                                                      new Text("${snapshot.data[index].data["Title"]}",
                                                        style: new TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 14.0,
                                                            color: Colors.black),),

                                                      new Text("${snapshot.data[index].data["preacher"]}",
                                                        style: new TextStyle(
                                                          color: Colors.red[500],
                                                          fontSize: 10.0,),),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

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
  String video;
  String itemDescription;
  String reading1;
  String reading2;
  String reading3;
  final index;

  videoDetail({

    this.itemName,
    this.itemPreacher,
    this.itemSubName,
    this.itemImage,
    this.video,
    this.itemDescription,
    this.reading1,
    this.reading2,
    this.reading3,
    this.index
  });


  @override
  _videoDetailState createState() => _videoDetailState();
}

class _videoDetailState extends State<videoDetail> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      widget.video,
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemName),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,0.0),
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the VideoPlayerController has finished initialization, use
                  // the data it provides to limit the aspect ratio of the video.
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    // Use the VideoPlayer widget to display the video.
                    child: VideoPlayer(_controller),
                  );
                } else {
                  // If the VideoPlayerController is still initializing, show a
                  // loading spinner.
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),

          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("Sermon title:",
                    style: new TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: Colors.black),),
                  new Text(widget.itemName,
                    style: new TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: Colors.black),),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("Preacher:",
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,),),
                  new Text(widget.itemPreacher,
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,),),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("First reading",
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,),),
                  new Text(widget.reading1,
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("Second reading",
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,),),
                  new Text(widget.reading2,
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("Third reading",
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,),),
                  new Text(widget.reading3,
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,),),
                ],
              ),
            ],
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
