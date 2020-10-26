import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'account_details.dart';
import 'editprofile.dart';

class Profile extends StatelessWidget {
  static const id = '/Profile';

  @override
  Widget build(BuildContext context) {
    Accounts details = Provider.of<Accounts>(context);



    Widget tiles(String listTitle, String subTitle) {
      return Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Icon(Icons.people),
            title: Text(listTitle),
            subtitle: Text(
              subTitle,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => {
              Navigator.of(context).pushNamed(EditProfile.id),
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
              child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[ 
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(details.items[0].imageUrl),
              ),
              SizedBox(
                height: 10,
              ),
              tiles('Roll Call:', '${details.items[0].id}'),
              SizedBox(
                height: 10,
              ),
              tiles('Name', '${details.items[0].name}'),
              SizedBox(
                height: 10,
              ),
              tiles('MobileNumber', '${details.items[0].mobileNumber}'),
              SizedBox(
                height: 10,
              ),
              tiles('Address:', '${details.items[0].address}'),
              SizedBox(
                height: 10,
              ),
              tiles('EmailId:', '${details.items[0].emailId}')
            ],
          ),
        ),
      ),
    );
  }
}
