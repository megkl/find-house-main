import 'dart:async';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhouse/helpers/properties.dart';
import 'package:findhouse/helpers/user.dart';
import 'package:findhouse/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:findhouse/models/properties.dart';

import 'home_searcher/propertiesNotifier.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserNotifier with ChangeNotifier {
  final FirebaseAuth _auth;
  User? _user;
  Status? _status = Status.Uninitialized;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserServices _UserServices = UserServices();
  final PropertyServices _propertyServices = PropertyServices();
  List<Properties>? _propertiesList = [];
  Properties? _currentProperty;

  UnmodifiableListView<Properties> get propertiesList => UnmodifiableListView(_propertiesList!);

  Properties get currentProperty => _currentProperty!;


  UserModel? _users;
  List<Properties>? properties = <Properties>[];


//  getter
  Status get status => _status!;

  User? get user => _user;

  UserModel? get users => _users;


  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phoneNo = TextEditingController();

  UserNotifier.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim() )
          .then((result) {
        _firestore.collection('User').doc(result.user!.uid).set({
          'name': name.text,
          'sellerPhoneNumber': phoneNo.text,
          'email': email.text,
          'id': result.user!.uid,
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
    phoneNo.text="";
  }

  set propertiesList(List<Properties> propertiesList) {
    _propertiesList = propertiesList;
    notifyListeners();
  }

  set currentProperty(Properties properties) {
    _currentProperty = properties;
    notifyListeners();
  }

  addProperty(Properties properties) {
    _propertiesList!.insert(0, properties);
    notifyListeners();
  }
  deleteproperty(documentId) {
    _firestore.collection('Properties').doc(documentId).delete();
  }
  deleteProperty(Properties properties) {
    _propertiesList!.removeWhere((properties) => properties.id == properties.id);
    notifyListeners();
  }

  Future<void> reload() async {
    _users = await _UserServices.getUserById(id: user!.uid);
    await loadProperties(sellerId: users!.phoneNo);


    notifyListeners();
  }

  Future<void> _onStateChanged(User? user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _status = Status.Authenticated;
      await loadProperties(sellerId: user.uid);
      _users = await _UserServices.getUserById(id: user.uid);
    }
    notifyListeners();
  }


  Future loadProperties({String? sellerId}) async {
    properties = await _propertyServices.getPropertiesBySeller(id: sellerId);
    notifyListeners();
  }
  getProperties(PropertyNotifier propertyNotifier) async {

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Properties')
        .where("sellerId",isEqualTo: user!.uid)
        .orderBy("dateAdded", descending: true)
        .get();

    List<Properties> propertiesList = [];

    snapshot.docs.forEach((document) {
      Properties properties = Properties.fromMap(document.data as Map<String, dynamic>);
      propertiesList.add(properties);
    });

    propertyNotifier.propertiesList = propertiesList;
  }
}
