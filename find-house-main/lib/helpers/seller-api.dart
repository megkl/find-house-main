import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhouse/models/properties.dart';
import 'package:findhouse/notifiers/user_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? _user;
User? get user => _user;

getProperties(UserNotifier userNotifier) async {

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Properties')
      .where("sellerId",isEqualTo: userNotifier.user!.uid)
      .orderBy("dateAdded", descending: true)
      .get();

  List<Properties> propertiesList = [];

  snapshot.docs.forEach((document) {
    Properties properties = Properties.fromMap(document.data()! as Map<String, dynamic>);
    propertiesList.add(properties);
  });

  userNotifier.propertiesList = propertiesList;
}

