import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const SELLERPHONENO = "sellerPhoneNumber";


  String? _name;
  String? _email;
  String? _id;
  String? _phoneNo;


//  getters
  String get name => _name!;

  String get email => _email!;

  String get id => _id!;

  String get phoneNo => _phoneNo!;

 UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;

    _id = data?[ID];
    _name = data?[NAME] ?? '';
    _email = data?[EMAIL] ?? '';
    _phoneNo = data?[SELLERPHONENO] ?? '';
  }

}