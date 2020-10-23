import 'package:agri_app/widgets/appbar.dart';
import 'package:agri_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

const String ssd = "Start Classification";

class PictureSearch extends StatefulWidget {
  static const String id = '/pictures';

  PictureSearch();

  @override
  _PictureSearchState createState() => _PictureSearchState();
}

class _PictureSearchState extends State<PictureSearch> {
  @override
  void initState() {
    super.initState();
  }

  File pickedImage;
  var text = '';
  var lab = '';

  bool imageLoaded = false;

  Future pickImage() async {
    text = '';
    var awaitImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = awaitImage;
      imageLoaded = true;
    });

    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);

    final ImageLabeler cloudLabeler =
        FirebaseVision.instance.cloudImageLabeler();

    final List<ImageLabel> cloudLabels =
        await cloudLabeler.processImage(visionImage);

    for (ImageLabel label in cloudLabels) {
      final String confidence = label.confidence.toStringAsFixed(2);
      setState(() {
        lab = label.text;
        text = "$text $lab   $confidence \n";
        print(label.text);

        print(text);
      });
    }

    cloudLabeler.close();
  }

  Future cameraImage() async {
    var awaitImage = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      pickedImage = awaitImage;
      imageLoaded = true;
    });

    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);

    final ImageLabeler cloudLabeler =
        FirebaseVision.instance.cloudImageLabeler();

    final List<ImageLabel> cloudLabels =
        await cloudLabeler.processImage(visionImage);

    for (ImageLabel label in cloudLabels) {
      final String confidence = label.confidence.toStringAsFixed(2);
      setState(() {
        lab = label.text;
        text = "$text $lab   $confidence \n";
        print(label.text);

        print(text);
      });
    }

    cloudLabeler.close();
  }

  @override
  Widget build(BuildContext context) {
    // Size screen = MediaQuery.of(context).size;
    return Scaffold(
        appBar: Topbar('Picture Search', []),
        drawer: MainDrawer(),
        body: Stack(
          children: [
            Column(
              children: <Widget>[
                SizedBox(height: 50.0),
                imageLoaded
                    ? Center(
                        child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(blurRadius: 20),
                          ],
                        ),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                        height: 250,
                        child: Image.file(
                          pickedImage,
                          fit: BoxFit.cover,
                        ),
                      ))
                    : Container(),
                SizedBox(height: 10.0),
                imageLoaded ==false?Center(
                  child: FlatButton.icon(
                    icon: Icon(
                      Icons.photo_camera,
                      size: 80,
                      color: Colors.blueAccent,
                    ),
                    label: Text('Selct picture here'),
                    textColor: Colors.blueAccent,
                    onPressed: () async {
                      pickImage();
                    },
                  ),
                ):Container(),
                SizedBox(height: 10.0),
                text == ''
                    ? Container()
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              text,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            imageLoaded
                ? Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            text = '';
                            imageLoaded = false;
                          });
                        }),
                  )
                : Container(),
             imageLoaded == false ?Positioned(
               bottom: 5,left:50,right: 50,
                            child: InkWell(
                    onTap: () async {
                      cameraImage();
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.camera,
                        size: 80,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
             ):Container()
          ],
        ),
    );
  }
}
