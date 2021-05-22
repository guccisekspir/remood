import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remood/models/users.dart';

class DatabaseApiClient {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Users> getUser(String userID) async {
    DocumentSnapshot userData = await firestore.doc("users/$userID").get();

    Users fetchedUser = Users.fromMap(userData.data() as Map<String, dynamic>);
    debugPrint(fetchedUser.name);

    return fetchedUser;
  }

  Future<bool> saveUser(Users willSaveUser) async {
    try {
      firestore.doc("users/${willSaveUser.uid}").set(willSaveUser.toMap());
      return true;
    } catch (e) {
      debugPrint("hata" + e.toString());
      return false;
    }
  }
}
