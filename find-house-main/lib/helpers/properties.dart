import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhouse/models/properties.dart';

class PropertyServices {
  String collection = "Properties";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future createProperty({Map? data})async{
    _firestore.collection(collection).doc(data!['id']).set({
      "id": data['id'],
      "name": data['name'],
      "image": data['image'],
      "category": data['category'],
      "desc": data['desc'],
      "price": data['price'],
      "bedRoomNo": data['bedRoomNo'],
      "sellerPhoneNumber": data['sellerPhoneNumber'],
      "roomImages": data['roomImages'],
      "featured": data['featured'],
      "map": data['map'],
      "location": data['location'],
      "sellerId": data[''],
      "features": data['features'],
    });
  }

  Future<List<Properties>> getProperty() async =>
      _firestore.collection(collection).get().then((result) {
        List<Properties> properties = [];
        for (DocumentSnapshot property in result.docs) {
          properties.add(Properties.fromSnapshot(property));
        }
        return properties;
      });

  void likeOrDislikeProduct({String? id, List<String>? userLikes}){
    _firestore.collection(collection).doc(id).update({
      "userLikes": userLikes
    });
  }

  Future<List<Properties>> getPropertiesBySeller({String? id}) async =>
      _firestore
          .collection(collection)
          .where("sellerId", isEqualTo: id)
          .get()
          .then((result) {
        List<Properties> properties = [];
        for (DocumentSnapshot property in result.docs) {
          properties.add(Properties.fromSnapshot(property));
        }
        print("PRODUCTS: ${properties.length}");
        print("PRODUCTS: ${properties.length}");
        print("PRODUCTS: ${properties.length}");
        print("PRODUCTS: ${properties.length}");
        print("PRODUCTS: ${properties.length}");
        print("PRODUCTS: ${properties.length}");
        print("PRODUCTS: ${properties.length}");

        return properties;
      });

  Future<List<Properties>> getPropertiesByCategory({String? category}) async =>
      _firestore
          .collection(collection)
          .where("category", isEqualTo: category)
          .get()
          .then((result) {
        List<Properties> properties = [];
        for (DocumentSnapshot property in result.docs) {
          properties.add(Properties.fromSnapshot(property));
        }
        return properties;
      });

  Future<List<Properties>> searchProducts({String? productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName![0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt(['$searchKey\uf8ff'])
        .get()
        .then((result) {
      List<Properties> properties = [];
      for (DocumentSnapshot property in result.docs) {
        properties.add(Properties.fromSnapshot(property));
      }
      return properties;
    });
  }
}
