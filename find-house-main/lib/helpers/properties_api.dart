import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhouse/models/properties.dart';
import 'package:findhouse/notifiers/home_searcher/propertiesNotifier.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';


getProperties(PropertyNotifier propertyNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Properties')
      .orderBy("dateAdded", descending: true)
      .get();

  List<Properties> propertiesList = [];

  snapshot.docs.forEach((document) {
    Properties properties = Properties.fromMap(document.data as Map<String, dynamic>);
    propertiesList.add(properties);
  });

  propertyNotifier.propertiesList = propertiesList;
}

uploadPropertyAndImage(Properties properties, bool isUpdating, File localFile, Function propertyUploaded) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = const Uuid().v4();

    final Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('propertiesf/images/$uuid$fileExtension');

    await firebaseStorageRef.putFile(localFile).whenComplete(() => null).catchError((onError) {
      print(onError);
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _uploadProperties(properties, isUpdating, propertyUploaded, imageUrl: url);
  } else {
    print('...skipping image upload');
    _uploadProperties(properties, isUpdating, propertyUploaded);
  }
}

_uploadProperties(Properties properties, bool isUpdating, Function propertiesUploaded, {String? imageUrl}) async {
  CollectionReference propRef = FirebaseFirestore.instance.collection('Properties'); FirebaseFirestore.instance.collection('SellerUser') ;

  properties.image = imageUrl!;

  if (isUpdating) {
    properties.dateUpdated = Timestamp.now();

    await propRef.doc(properties.id).update(properties.toMap());

    propertiesUploaded(properties);
    print('updated properties with id: ${properties.id}');
  } else {
    properties.dateAdded = Timestamp.now();

    DocumentReference documentRef = await propRef.add(properties.toMap());
    properties.id = documentRef.id;

    print('uploaded properties successfully: ${properties.toString()}');

    // await documentRef.set(properties.toMap(), merge: true);
    await documentRef.set(properties.toMap());

    propertiesUploaded(properties);
  }
}

deleteProperty(Properties properties, Function propertiesDeleted) async {
 Reference storageReference =
  await FirebaseStorage.instance.refFromURL(properties.image!);

  print(storageReference.fullPath);

  await storageReference.delete();

  print('image deleted');

  await FirebaseFirestore.instance.collection('Properties').doc(properties.id).delete();
  propertiesDeleted(properties);
}