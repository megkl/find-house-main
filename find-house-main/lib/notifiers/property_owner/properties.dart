import 'dart:collection';
import 'dart:io';
import 'package:findhouse/helpers/properties.dart';
import 'package:findhouse/models/properties.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class PropertiesProvider with ChangeNotifier{
  final PropertyServices _propertiesServices = PropertyServices();
  List<Properties> properties = [];
  List<Properties> propertiesByCategory = [];
  List<Properties> propertiesSearched = [];
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController bedRoomNo = TextEditingController();
  TextEditingController sellerPhoneNo = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  TextEditingController buyRent = TextEditingController();
  TextEditingController map = TextEditingController();

  bool featured = false;
  File? propertyImage;
  final picker = ImagePicker();
  String? propertyImageFileName;
  PropertiesProvider.initialize(){
    loadProperties();
  }

  loadProperties()async{
    properties = await _propertiesServices.getProperty();
    notifyListeners();
  }

  Future loadPropertiesByCategory({String? categoryName})async{
    propertiesByCategory = await _propertiesServices.getPropertiesByCategory(category: categoryName);
    notifyListeners();
  }



  Future<bool> uploadProperty({String? category, String? sellerId})async{
    try{
      String id = const Uuid().v1();
      String imageUrl = await _uploadImageFile(imageFile: propertyImage!, imageFileName: id);

      Map data = {
        "id": id,
        "name": name.text.trim(),
        "image": imageUrl,
        "sellerId": sellerId,
        "category": category,
        "bedRoomNo": bedRoomNo.text.trim(),
        "sellerPhoneNumber": sellerPhoneNo.text.trim(),
        //"price": double.parse(price.text.trim()),
        price: price.text.trim(),
        "buyRent": buyRent,
        "location": location,
        "desc": desc.text.trim(),
        //"map": [{double.parse(latitude.text.trim()), double.parse(longitude.text.trim()) }],
        "featured": featured
      };
      _propertiesServices.createProperty(data: data);
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }

  }

  changeFeatured(){
    featured = !featured;
    notifyListeners();
  }

//  method to load image files
  getImageFile({ImageSource? source})async{
    final pickedFile = await picker.pickImage(source: source!, maxWidth: 640, maxHeight: 400);
    propertyImage = File(pickedFile!.path);
    propertyImageFileName = propertyImage!.path.substring(propertyImage!.path.indexOf('/' ) + 1);
    notifyListeners();
  }
  
//  method to upload the file to firebase
  Future _uploadImageFile({File? imageFile, String? imageFileName})async{
    Reference reference = FirebaseStorage.instance.ref().child(imageFileName!);
    UploadTask uploadTask = reference.putFile(imageFile!);
    String imageUrl = await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
    return imageUrl;
  }


  Future search({String? productName})async{
    propertiesSearched = await _propertiesServices.searchProducts(productName: productName);
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${propertiesSearched.length}");
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${propertiesSearched.length}");
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${propertiesSearched.length}");

    notifyListeners();
  }
  List<Properties> _propertiesList = [];
  Properties? _currentProperty;

  UnmodifiableListView<Properties> get propertiesList => UnmodifiableListView(_propertiesList);

  Properties get currentProperty => _currentProperty!;

  set propertiesList(List<Properties> propertiesList) {
    _propertiesList = propertiesList;
    notifyListeners();
  }

  set currentProperty(Properties properties) {
    _currentProperty = properties;
    notifyListeners();
  }

  addProperty(Properties properties) {
    _propertiesList.insert(0, properties);
    notifyListeners();
  }

  deleteProperty(Properties properties) {
    _propertiesList.removeWhere((properties) => properties.id == properties.id);
    notifyListeners();
  }

  clear(){
   /*propertyImage = null;
    propertyImageFileName= null;
    name = null;
    desc = null;
    price = null;*/
  }


}