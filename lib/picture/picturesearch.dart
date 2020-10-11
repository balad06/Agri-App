import 'package:agri_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import 'camera.dart';
import 'render.dart';

const String ssd = "Start Classification";

class PictureSearch extends StatefulWidget {
  static const String id = '/pictures';
  final List<CameraDescription> cameras;

  PictureSearch(this.cameras);

  @override
  _PictureSearchState createState() => _PictureSearchState();
}

class _PictureSearchState extends State<PictureSearch> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  @override
  void initState() {
    super.initState();
  }

  loadModel() async {
    String res;

    switch (_model) {
      default:
        res = await Tflite.loadModel(
          model: "assets/mobilenet_v1_1.0_224_quant.tflite",
          labels: "assets/labels_mobilenet_quant_v1_224.txt",
        );

        break;
    }
    print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Picture',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight:Radius.circular(27),
              bottomLeft:Radius.circular(27),
            ),
          ),
        ),
        drawer: MainDrawer(),
        body: _model == ""
            ? Center(
                child: RotatedBox(
                    quarterTurns: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/logo.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ButtonTheme(
                            child: RaisedButton(
                              child:
                                  Text(ssd, style: TextStyle(fontSize: 25.0)),
                              onPressed: () => onSelect(ssd),
                            ),
                          )
                        ],
                      ),
                    )))
            : Stack(
                children: [
                  RotatedBox(
                      quarterTurns: -1,
                      child: Camera(
                        widget.cameras,
                        _model,
                        setRecognitions,
                      )),
                  Render(
                    _recognitions == null ? [] : _recognitions,
                    math.max(_imageHeight, _imageWidth),
                    math.min(_imageHeight, _imageWidth),
                    screen.height,
                    screen.width,
                  ),
                ],
              ),
      ),
    );
  }
}
