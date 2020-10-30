import 'package:agri_app/widgets/appbar.dart';
import 'package:agri_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:agri_app/login/auth.dart';

class ProfileView extends StatefulWidget {
  static const id = 'Profile';
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Map<String, dynamic> user = {
    'address': '296,Thiruverkadu,chennai-77',
  };
  bool _isEdit = false;
  TextEditingController _userCountryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Topbar('Profile', []),
      drawer: MainDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              future:
                  Provider.of<Auth>(context, listen: false).getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget tiles(Icon icon, String listTitle, String subTitle) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: icon,
          title: Text(listTitle),
          subtitle: Text(
            subTitle,
          ),
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final authData = snapshot.data;
    _userCountryController.text = user['address'];
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Provider.of<Auth>(context).getProfileImage(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: tiles(Icon(Icons.people), 'Name',
              '${authData.displayName ?? 'Anonymous'}'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: tiles(
              Icon(Icons.email), 'Email', '${authData.email ?? 'Anonymous'}'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: tiles(Icon(Icons.new_releases), 'Created:',
              '${DateFormat('MM/dd/yyyy').format(authData.metadata.creationTime)}'),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Address'),
                        subtitle: Text(
                          '${_userCountryController.text}',
                        ),
                        trailing: IconButton(
                          color: Colors.blueAccent,
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              _isEdit = !_isEdit;
                            });
                          },
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
