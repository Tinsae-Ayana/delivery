import 'package:flutter/foundation.dart';
import 'package:sura_online_shopping_admin/commons/models/user.dart';
import 'package:sura_online_shopping_admin/feature_order/models/order.dart';
import 'package:sura_online_shopping_admin/feature_product/models/product.dart';
import 'package:sura_online_shopping_admin/repository/data_provider/firebase_authenticatin.dart';
import 'package:sura_online_shopping_admin/repository/data_provider/firebase_data.dart';
import 'package:sura_online_shopping_admin/repository/data_provider/internet_connection.dart';
import 'package:sura_online_shopping_admin/repository/data_provider/storage.dart';

class Services {
  Services(
      {InternetConnectionAvailabilty? internetConnectionAvailabilty,
      AuthenticationWithFirebase? authenticationWithFirebase,
      FirebaseData? firebaseData,
      Storage? storage})
      : _internetConnectionAvailabilty =
            internetConnectionAvailabilty ?? InternetConnectionAvailabilty(),
        _authenticationWithFirebase =
            authenticationWithFirebase ?? AuthenticationWithFirebase(),
        _firebaseData = firebaseData ?? FirebaseData(),
        _storage = storage ?? Storage();

  final InternetConnectionAvailabilty _internetConnectionAvailabilty;
  final AuthenticationWithFirebase _authenticationWithFirebase;
  final FirebaseData _firebaseData;
  final Storage _storage;

  //check for connection
  Stream<bool> isConnectionAvailable() {
    return _internetConnectionAvailabilty.isConnectedToStatus();
  }

  //authentication

  Future<String> verfiyPhoneNumber({phoneNumber}) async {
    final message =
        await _authenticationWithFirebase.veryfiyPhoneNumber(phoneNumber);
    return message;
  }

  void signInwithCredential({sms}) {
    _authenticationWithFirebase.signInwithCredential(sms);
  }

  bool isUserLoggedIn() {
    return _authenticationWithFirebase.isUserIsLoggedIn();
  }

  String? loggedInUser() {
    return _authenticationWithFirebase.loggedInUser();
  }

  void logOut() {
    _authenticationWithFirebase.logout();
  }

  // user

  writeUsertoFirebase({json, id}) {
    _firebaseData.writeOntoFirebaseWithId(
        id: id, json: json, collectionName: 'user');
  }

  Future<User> readUserFromFirebase({id}) async {
    final json =
        await _firebaseData.readOneData(collectionName: 'user', id: id);
    return User.fromJson(json!);
  }

  // products
  String postProduct({json}) {
    return _firebaseData.writeOntoFirebase(
        json: json, collectionName: 'product');
  }

  void deleteProduct({id}) {
    _firebaseData.deleteData(collectionName: 'product', id: id);
  }

  Stream<List<Product>> retrieveAllProduct() {
    return _firebaseData
        .realTimeData(collectionName: 'product')
        .map((map) => map.map((e) => Product.fromJson(e)).toList());
  }

  Stream<List<Product>> retrieveProductByCatagory({catagoryName}) {
    debugPrint('inside the retrieval method');
    return _firebaseData
        .catagoriesList(catagoryName: catagoryName, collectionName: 'product')
        .map((event) => event.map((e) => Product.fromJson(e)).toList());
  }

  Stream<List<Product>> retrieveNewArrival() {
    return _firebaseData
        .newArrival()
        .map((event) => event.map((e) => Product.fromJson(e)).toList());
  }

  Future<List<Product>> search({searchKey}) async {
    final productSearch = await _firebaseData.search(searchKey: searchKey);
    return productSearch.map((e) => Product.fromJson(e)).toList();
  }

  void updateProduct({id, data}) {
    _firebaseData.updateData(id: id, collectionName: 'product', data: data);
  }

  //Orders
  String postOrders({json}) {
    return _firebaseData.writeOntoFirebase(
        json: json, collectionName: 'orders');
  }

  void deleteOrders({id}) {
    _firebaseData.deleteData(collectionName: 'orders', id: id);
  }

  Stream<List<Order>> retrieveAllOrders() {
    debugPrint('inside the retrieve me');
    return _firebaseData
        .realTimeData(collectionName: 'orders')
        .map((map) => map.map((e) {
              debugPrint(e.toString());
              debugPrint(Order.fromJson(e).toString());
              return Order.fromJson(e);
            }).toList());
  }

  void updateOrders({id, data}) {
    _firebaseData.updateData(id: id, collectionName: 'order', data: data);
  }
  // post images to

  Future<List<String>> postProductPhoto({file}) async {
    return await _storage.postProductImages(productImages: file);
  }

  Future<String> postUserPhoto({file}) async {
    return await _storage.postUserPhoto(image: file);
  }
}
