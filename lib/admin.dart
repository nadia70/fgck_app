import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thumbnails/thumbnails.dart';
import 'package:video_player/video_player.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  File videoFile;
  TextEditingController prodcutTitle = new TextEditingController();
  TextEditingController prodcutPrice = new TextEditingController();



  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    super.initState();
  }



 void addNewProducts() async{
    if (videoFile == null) {
      final snackbar = SnackBar(
        content: Text('you have not selected a video'),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    }

    if (prodcutTitle.text == "") {
      final snackbar = SnackBar(
        content: Text('Enter Title'),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    }

    if (prodcutPrice.text == "") {
      final snackbar = SnackBar(
        content: Text('Enter Preacher Name'),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    }

    else {
      StorageReference reference =
      FirebaseStorage.instance.ref().child(videoFile.path.toString());
      StorageUploadTask uploadTask = reference.putFile(videoFile);

      StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;

      String url = await downloadUrl.ref.getDownloadURL();

      Center(
        child: CircularProgressIndicator(),
      );

      String thumb = await Thumbnails.getThumbnail( // creates the specified path if it doesnt exist
          videoFile: url,
          imageType: ThumbFormat.PNG,
          quality: 30);

      await Firestore.instance.runTransaction((Transaction transaction) async {
        CollectionReference reference = Firestore.instance.collection(
            'videos');

        await reference.add({
          "Title": prodcutTitle.text,
          "preacher": prodcutPrice.text,
          "video": url,
          "thumbNail": thumb,
          "time": DateTime.now()
        });
      }).then((result) =>

          _showRequest());
    }
  }

  void _showRequest() {
    // flutter defined function

    setState(() {
      prodcutTitle.text= "";
      prodcutPrice.text="";
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Your data has been saved"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
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
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.deepPurple[900],
      appBar: AppBar(
        title: Text('ADMIN'),
          backgroundColor: Colors.deepPurple[900],
        centerTitle: true,
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Visibility(
              visible: _controller != null,
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
            Center(
              child: new RaisedButton.icon(
                  color: Colors.green,
                  shape: new RoundedRectangleBorder(
                      borderRadius:
                      new BorderRadius.all(new Radius.circular(15.0))),
                  onPressed: () => getVideo(),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: new Text(
                    "Select video to upload",
                    style: new TextStyle(color: Colors.white),
                  )),

            ),
            new SizedBox(
              height: 10.0,
            ),
            productTextField(
                textTitle: "Sermon Title",
                textHint: "Enter Sermon Title",
                controller: prodcutTitle),
            new SizedBox(
              height: 10.0,
            ),
            productTextField(
                textTitle: "Preacher name",
                textHint: "Enter Preacher name",
                controller: prodcutPrice),
            new SizedBox(
              height: 10.0,
            ),
            new SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: new EdgeInsets.all(10.0),
              child: new RaisedButton(
                color: Colors.green,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.all(new Radius.circular(15.0))),
                onPressed: addNewProducts,
                child: Container(
                  height: 50.0,
                  child: new Center(
                    child: new Text(
                      "save",
                      style: new TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
      floatingActionButton: _controller == null
          ? null
          : FloatingActionButton(
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

  Future getVideo() async {
    Future<File> _videoFile =
    ImagePicker.pickVideo(source: ImageSource.gallery);
    _videoFile.then((file) async {
      setState(() {
        videoFile = file;
        _controller = VideoPlayerController.file(videoFile);

        // Initialize the controller and store the Future for later use.
        _initializeVideoPlayerFuture = _controller.initialize();

        // Use the controller to loop the video.
        _controller.setLooping(true);
      });
    });
  }
}

Widget productTextField(
    {String textTitle,
      String textHint,
      double height,
      TextEditingController controller,
      TextInputType textType}) {
  textTitle == null ? textTitle = "Enter Title" : textTitle;
  textHint == null ? textHint = "Enter Hint" : textHint;
  height == null ? height = 50.0 : height;
  //height !=null

  return Column(
    //mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Text(
          textTitle,
          style:
          new TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      new Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: new Container(
          height: height,
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: Colors.white),
              borderRadius: new BorderRadius.all(new Radius.circular(4.0))),
          child: new Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new TextField(
              controller: controller,
              keyboardType: textType == null ? TextInputType.text : textType,
              maxLines: 4,
              decoration: new InputDecoration(
                  border: InputBorder.none, hintText: textHint),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget appButton(
    {String btnTxt,
      double btnPadding,
      Color btnColor,
      VoidCallback onBtnclicked}) {
  btnTxt == null ? btnTxt == "App Button" : btnTxt;
  btnPadding == null ? btnPadding = 0.0 : btnPadding;
  btnColor == null ? btnColor = Colors.black : btnColor;

  return Padding(
    padding: new EdgeInsets.all(btnPadding),
    child: new RaisedButton(
      color: Colors.green,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.all(new Radius.circular(15.0))),
      onPressed: onBtnclicked,
      child: Container(
        height: 50.0,
        child: new Center(
          child: new Text(
            btnTxt,
            style: new TextStyle(color: btnColor, fontSize: 18.0),
          ),
        ),
      ),
    ),
  );
}

