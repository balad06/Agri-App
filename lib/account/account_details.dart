import 'package:flutter/foundation.dart';

class Account with ChangeNotifier {
  String id;
  String name;
  final String imageUrl;
  String mobileNumber;
  String address;
  String emailId;

  Account({
    @required this.id,
    @required this.name,
    this.imageUrl,
    @required this.mobileNumber,
    @required this.address,
    @required this.emailId,
  });
}

class Accounts with ChangeNotifier {
  List<Account> _items = [
    Account(
        id: '120',
        name: 'Student',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTEE4wMI4iq3faNnWfb-mnj2LvfiwRxb1ai3GBUr2ggSgTsl9Ut&usqp=CAU',
        mobileNumber: '63832246233',
        address: 'parent',
        emailId: 'baaabois@gmail.com'),
  ];
  List<Account> get items {
    return [..._items];
  }

  Future<void> updateProfile(String id, Account student) async {
    for (int i = 0; i < _items.length; i++)
      if (_items[i].id == id) {
        _items[i].name = student.name;
        _items[i].address = student.address;
        _items[i].mobileNumber = student.mobileNumber;
        _items[i].emailId = student.emailId;
      }
      notifyListeners();
  }
}