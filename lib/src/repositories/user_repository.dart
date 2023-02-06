import 'dart:io';

import 'package:brilloconnetz_test/src/features/authentication/model/register_params.dart';
import 'package:brilloconnetz_test/src/features/profile/model/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserRepository {
  UserRepository();

  final userCollection = FirebaseFirestore.instance.collection('users');
  FirebaseStorage storage = FirebaseStorage.instance;
  Future<AppUser> getFutureUser(String userId) async {
    final snapshot = await userCollection.doc(userId).get();
    return AppUser.fromMap(snapshot);
  }

  Stream<AppUser> getUser(String userId) {
    return userCollection.doc(userId).snapshots().map(
          (documentSnapshot) => AppUser.fromMap(
            documentSnapshot,
          ),
        );
  }

  // get Users
  Stream<List<AppUser>> getUsers() {
    return userCollection.snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (queryDocumentSnapshot) =>
                    AppUser.fromMap(queryDocumentSnapshot),
              )
              .toList(),
        );
  }

  Future<void> createUserWithId(
    String userId, {
    required RegisterParams params,
  }) async {
    return await userCollection.doc(userId).set(params.toMap());
  }

  Future<AppUser> updateImage(
    String userId, {
    required String imageUrl,
  }) async {
    await userCollection.doc(userId).update({
      'imageUrl': imageUrl,
    });

    return getFutureUser(userId);
  }

//update user
  Future<AppUser> updateUserWithId(
    String userId, {
    required String userName,
  }) async {
    await userCollection.doc(userId).update({
      'userName': userName,
    });

    return getFutureUser(userId);
  }

//upload image to firebase storage and get the image url

  Future<String> uploadImage(String imagePath) async {
    Reference ref =
        storage.ref().child('forumImages${DateTime.now().toIso8601String()}');
    await ref.putFile(File(imagePath));
    String imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }
}

final userRepository = Provider<UserRepository>((ref) => UserRepository());
final usersProvider = StreamProvider<List<AppUser>>((ref) {
  return ref.watch(userRepository).getUsers();
});
