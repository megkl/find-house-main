
import 'package:cloud_firestore/cloud_firestore.dart';

class Properties {
  String? id;
  String? name;
  String? displayName;
  Timestamp? dateAdded;
  Timestamp? dateUpdated;
  String? category;
  List? features = [];
  String? ownerImages;
  String? image;
  List? roomImages =[];
  String? sellerPhoneNumber;
  String? sellerId;
  String? roomSizes;
  String? desc;
  String? location;
  GeoPoint? map;
  String? bedRoomNo;
  String? price;
  bool? featured;

  Properties(
      {this.bedRoomNo,
        this.id,
        this.features,
        this.featured,
        this.name,
        this.sellerId,
        this.category,
        this.desc,
        this.location,
        this.price,
        this.dateAdded,
        this.dateUpdated,
        this.image,
        this.roomImages,
        this.roomSizes,
        this.sellerPhoneNumber,
        this.map,
      });

  String get _id => id!;
  List get _features => features!;
  String get _name => name!;
  String get _category => _category;
  String get _image => image!;
  String get _desc => desc!;
  List get _roomImages => roomImages!;
  String get _price => price!;
  String get _bedRoomNo => bedRoomNo!;
  String get _sellerId => sellerId!;
  String get _location => location!;
  Timestamp get _dateAdded => dateAdded!;
  String get _sellerPhoneNumber => sellerPhoneNumber!;

  Properties.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    displayName = data['displayName'];
    category = data['category'];
    //propertyTypeDetails = data['propertyTypeDetails'];
    image = data['image'];
    dateAdded = data['dateAdded'];
    dateUpdated = data['dateUpdated'];
    features = data['features'];
    roomImages = data['roomImages'];
    sellerPhoneNumber = data['sellerPhoneNumber'];
    roomSizes = data['roomSizes'];
    desc = data['desc'];
    location = data['location'];
    price = data['price'];
    sellerId = data['sellerId'];
    map = data['map'];
    bedRoomNo = data['bedRoomNo'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      //'displayName': displayName,
      'category': category,
      //'propertyTypeDetails' : propertyTypeDetails,
      'image': image,
      'dateAdded': dateAdded,
      'dateUpdated': dateUpdated,
      'features': features,
      'roomImages': roomImages,
      'sellerPhoneNumber': sellerPhoneNumber,
      'roomSizes': roomSizes,
      'desc': desc,
      'location': location,
      'price': price,
      'map': map,
      'bedRoomNo' : bedRoomNo,
      'sellerId' : sellerId,
      'featured' : featured
    };
  }

  Properties.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;

    id = data?['id'];
    name = data?['name'];
    category = data?['category'];
    //propertyTypeDetails = snapshot['propertyTypeDetails'];
    image = data?['image'];
    dateAdded = data?['dateAdded'];
    dateUpdated = data?['dateUpdated'];
    features = data?['features'];
    roomImages = data?['roomImages'];
    sellerPhoneNumber = data?['sellerPhoneNumber'];
    sellerId = data?['sellerId'];
    roomSizes = data?['roomSizes'];
    desc = data?['desc'];
    location = data?['location'];
    price = data?['price'];
    map = data?['map'];
    bedRoomNo = data?['bedRoomNo'];
  }

}