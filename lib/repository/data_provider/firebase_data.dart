import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseData {
  FirebaseData({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  final FirebaseFirestore _firebaseFirestore;

// write
  String writeOntoFirebase({json, collectionName}) {
    final doc = _firebaseFirestore.collection(collectionName).doc();
    final id = doc.id;
    json['id'] = id;
    doc.set(json);
    return id;
  }

  writeOntoFirebaseWithId({json, collectionName, id}) {
    debugPrint('================>');
    debugPrint('writing the user data in the firebase');
    final doc = _firebaseFirestore.collection(collectionName).doc(id);
    doc.set(json);
  }

  // read

  Stream<List<Map<String, dynamic>>> realTimeData({collectionName}) {
    return _firebaseFirestore
        .collection(collectionName)
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  Stream<List<Map<String, dynamic>>> catagoriesList(
      {collectionName, catagoryName}) {
    return _firebaseFirestore
        .collection(collectionName)
        .where('catagory', isEqualTo: catagoryName)
        .orderBy('timeOfPost', descending: false)
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  Stream<List<Map<String, dynamic>>> newArrival() {
    return _firebaseFirestore
        .collection('product')
        .orderBy('timeOfPost', descending: false)
        .limit(3)
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  Future<List<Map<String, dynamic>>> search({searchKey}) {
    return _firebaseFirestore
        .collection('product')
        .where('productName', isEqualTo: searchKey)
        .get()
        .then((value) {
      return value.docs.map((e) => e.data()).toList();
    });
  }

  Future<List<Map<String, dynamic>>> readAllData({collectionName}) async {
    final snapshot = await _firebaseFirestore.collection(collectionName).get();
    final docList = snapshot.docs;
    return docList.map((doc) => doc.data()).toList();
  }

  Future<Map<String, dynamic>?> readOneData({collectionName, id}) async {
    final doc = _firebaseFirestore.collection(collectionName).doc(id);
    final snapshot = await doc.get();
    return snapshot.data();
  }

//update
  void updateData({collectionName, id, data}) {
    final doc = _firebaseFirestore.collection(collectionName).doc(id);
    doc.set(data);
  }

// delete
  void deleteData({collectionName, id}) {
    final docs = _firebaseFirestore.collection(collectionName).doc(id);
    docs.delete();
  }
}
