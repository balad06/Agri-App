import 'package:flutter/material.dart';

class Topbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> myActions;
  Topbar(this.title, this.myActions);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(
          title,
        ),
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //       colors: [Colors.blueAccent[200], Colors.lightGreen],
        //     ),
        //   ),
          
        // ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(27),
            bottomRight: Radius.circular(27),
          ),
        ),
        actions: myActions);
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
