import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class StorageRepo {
  final storage = FirebaseStorage.instance.ref();

  StorageRepo();

  Future<String?> uploadUsersProfileFile(File file) async {
    final user = FirebaseAuth.instance.currentUser!;
    var storageRef = storage.child("users/profile/${user.uid}");
    try {
      await storageRef.putFile(file);
      return storage.child("users/profile/${user.uid}").getDownloadURL();
    } on FirebaseException catch (e) {
      debugPrint('FirebaseException: $e');
    }
    return null;
  }
}