import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserServices {
  String collection = "User";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getUsers() async =>
      _firestore.collection(collection).get().then((result) {
        List<UserModel> users = [];
        for(DocumentSnapshot user in result.docs){
          users.add(UserModel.fromSnapshot(user));
        }
        return users;
      });

  Future<UserModel> getUserById({String? id}) => _firestore.collection(collection).doc(id.toString()).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });

  Future<List<UserModel>> searchUser({String? name}) {
    String searchKey = name![0].toUpperCase() + name.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
      List<UserModel> users = [];
      for (DocumentSnapshot property in result.docs) {
        users.add(UserModel.fromSnapshot(property));
      }
      return users;
    });
  }

}