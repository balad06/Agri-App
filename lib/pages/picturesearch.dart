import 'package:agri_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

class PictureSearch extends StatefulWidget {
  static const String id = '/pictures';
  @override
  _PictureSearchState createState() => _PictureSearchState();
}

class _PictureSearchState extends State<PictureSearch> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text('Picture'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(27),
            ),
          ),
        ),
        drawer: MainDrawer(),
        body: Center(child: Text('Picture Search')),
      ),
    );
  }
}
