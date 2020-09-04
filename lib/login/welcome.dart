import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static const String id = '/WelcomePage';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image(
                        image: AssetImage('assets/images/agrilogo1.jpg'),
                        fit: BoxFit.cover),
                    SizedBox(height: 10.0),
                    Padding(
                      child: Text(
                        'Welcome',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 39.0,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 35.0),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(53.0, 50.0, 53.0, 0.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 5.0),
                        ],
                      ),
                    ),
                    SizedBox(height: 43.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.0),
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.0))),
                        child: Center(
                          child: InkWell(
                            // onTap: () {
                            //   Navigator.pushNamed(context, LoginPage.id,
                            //       arguments: 'Sign In');
                            // },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 22.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'New Here?   ',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                        ),
                        InkWell(
                          // onTap: () {
                          //   Navigator.pushNamed(context, LoginPage.id,
                          //       arguments: 'Register');
                          // },
                          child: Text(
                            'Create Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 200,
              left: -50,
              child: Opacity(
                opacity: .75,
                child: Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent, shape: BoxShape.circle),
                ),
              ),
            ),
            Positioned(
              right: -50,
              top: -40,
              child: Opacity(
                opacity: .9,
                child: Container(
                  width: 175.0,
                  height: 175.0,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent, shape: BoxShape.circle),
                ),
              ),
            ),
            Positioned(
              right: -50,
              bottom: -30,
              child: Opacity(
                opacity: .6,
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent, shape: BoxShape.circle),
                ),
              ),
            ),
            // Positioned(
            //   child: Opacity(
            //     opacity: .6,
            //     child: Container(
            //       width: 150.0,
            //       height: 150.0,
            //       decoration:
            //           BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
