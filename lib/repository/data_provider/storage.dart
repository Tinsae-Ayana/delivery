import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Storage {
  Future<List<String>> postProductImages(
      {required List<File> productImages}) async {
    final imageUrl =
        await Future.wait(productImages.map((e) => _postProductImage(e)));
    return imageUrl;
  }

  Future<String> _postProductImage(image) async {
    try {
      final imageRef =
          FirebaseStorage.instance.ref().child('products/${image.path}');
      await imageRef.putFile(image);
      return await imageRef.getDownloadURL();
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return '';
    }
  }

  Future<String> postUserPhoto({image}) async {
    final imageRef =
        FirebaseStorage.instance.ref().child('users/${image.path}');
    await imageRef.putFile(image);
    return await imageRef.getDownloadURL();
  }
}
