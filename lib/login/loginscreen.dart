import 'package:flutter/material.dart';

import '../widgets/login widgets/beziercontainer.dart';

class LoginPage extends StatefulWidget {
  static const String id = '/LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
            ),
            Text('Back',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * .60,
            child: TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                hintText: '$title',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton(String type) {
    if (type == 'Register') {
      return InkWell(
        // onTap: () {
        //   Navigator.pushReplacementNamed(context, ProfilePage.id,
        //       arguments: 'first');
        // },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * .85,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            color: Colors.green,
          ),
          child: Text(
            '$type',
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      return InkWell(
        // onTap: () {
        //   Navigator.pushReplacementNamed(
        //     context,
        //     DashBoard.id,
        //   );
        // },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * .85,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            color: Colors.teal,
          ),
          child: Text(
            '$type',
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  Widget _createAccountLabel(String type) {
    if (type == 'Sign In') {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'New Here?',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, LoginPage.id,
                    arguments: 'Register');
              },
              child: Text(
                'Register',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    } else if (type == 'Register') {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Have an Account?',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, LoginPage.id,
                    arguments: 'Sign In');
              },
              child: Text(
                'Login',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _registerForm(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .75,
            child: TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formWidget(String type) {
    if (type == 'Sign In') {
      return Container(
        width: MediaQuery.of(context).size.width * .85,
        height: MediaQuery.of(context).size.height * .4,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                _entryField('Email id'),
                SizedBox(height: 10),
                _entryField('Password', isPassword: true),
              ],
            ),
          ),
        ),
      );
    } else if (type == 'Register') {
      return Container(
        width: MediaQuery.of(context).size.width * .85,
        // height: MediaQuery.of(context).size.height * .4,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                _registerForm('Email id'),
                _registerForm('Password', isPassword: true),
                _registerForm('Confirm Password', isPassword: true),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget checkboxorforgot(String type) {
    if (type == 'Sign In') {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {},
          child: Text(
            'Forgot Password ?',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String type = ModalRoute.of(context).settings.arguments;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              left: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Positioned(
            left: -2,
            bottom: 200,
            child: Opacity(
              opacity: .4,
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                    color: Colors.blueAccent, shape: BoxShape.circle),
              ),
            ),
          ),
          Positioned(
              right: -20,
              bottom: -20,
              child: Opacity(
                opacity: .4,
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent, shape: BoxShape.circle),
                ),
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .15),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    alignment: Alignment.center,
                    child: Text(
                      '$type',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.blueAccent),
                    ),
                  ),
                  SizedBox(height: height * .02),
                  _formWidget(type),
                  SizedBox(height: height * .002),
                  checkboxorforgot(type),
                  SizedBox(height: height * .05),
                  _submitButton(type),
                  _createAccountLabel(type),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}
