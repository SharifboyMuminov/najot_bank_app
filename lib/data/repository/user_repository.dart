import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/data/models/network_response.dart';
import 'package:untitled1/data/models/user/user_model.dart';
import 'package:untitled1/utils/app_contains.dart';

class UserRepository {
  static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<NetworkResponse> insertUser({required UserModel userModel}) async {
    NetworkResponse networkResponse = NetworkResponse();
    User? user = FirebaseAuth.instance.currentUser;
    String uuId = "";
    if (user != null) {
      // debugPrint("UUID insertUser: ${user.uid}------");
      uuId = user.uid;
    }

    try {
      DocumentReference documentReference = await _firebaseFirestore
          .collection(AppConstants.userTableName)
          .add(userModel.toJson());

      await _firebaseFirestore
          .collection(AppConstants.userTableName)
          .doc(documentReference.id)
          .update({"user_id": documentReference.id, "uu_id": uuId});

      networkResponse.data = userModel.copyWith(
        userId: documentReference.id,
        uuId: uuId,
      );
    } on FirebaseException catch (_) {
      networkResponse.errorText =
          "Error :(  on FirebaseException catch (_) insertUser";
    } catch (_) {
      networkResponse.errorText = "Error :( catch (_) insertUser";
    }

    return networkResponse;
  }

  Future<NetworkResponse> updateUser({required UserModel userModel}) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await _firebaseFirestore
          .collection(AppConstants.userTableName)
          .doc(userModel.userId)
          .update(userModel.toJson());
    } on FirebaseException catch (_) {
      networkResponse.errorText =
          "Error :(  on FirebaseException catch (_) updateUser";
    } catch (_) {
      networkResponse.errorText = "Error :( catch (_) updateUser";
    }

    return networkResponse;
  }

  Future<NetworkResponse> deleteUser({required UserModel userModel}) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await _firebaseFirestore
          .collection(AppConstants.userTableName)
          .doc(userModel.userId)
          .delete();
    } on FirebaseException catch (_) {
      networkResponse.errorText =
          "Error :(  on FirebaseException catch (_) deleteUser";
    } catch (_) {
      networkResponse.errorText = "Error :( catch (_) deleteUser";
    }

    return networkResponse;
  }

  Future<NetworkResponse> getUserByDocId({required String docId}) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      DocumentSnapshot documentSnapshot = await _firebaseFirestore
          .collection(AppConstants.userTableName)
          .doc(docId)
          .get();

      if (documentSnapshot.data() != null) {
        networkResponse.data =
            UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      } else {
        networkResponse.errorText = "No user :( getUserByDocId";
      }
    } on FirebaseException catch (_) {
      networkResponse.errorText =
          "Error :(  on FirebaseException catch (_) getUserByDocId ";
    } catch (_) {
      networkResponse.errorText = "Error :( catch (_) getUserByDocId ";
    }

    return networkResponse;
  }

  Future<NetworkResponse> getUserByUuId() async {
    NetworkResponse networkResponse = NetworkResponse();

    User? user = FirebaseAuth.instance.currentUser;
    String uuId = "";
    if (user != null) {
      // debugPrint("UUID getUserByUuId: ${user.uid}------");

      uuId = user.uid;
    }

    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection(AppConstants.userTableName)
          .where("uu_id", isEqualTo: uuId)
          .get();

      List<UserModel> users = querySnapshot.docs
          .map((e) => UserModel.fromJson(UserModel.convertMap(e)))
          .toList();
      // debugPrint(querySnapshot.docs.toString());

      networkResponse.data = users.isEmpty ? UserModel.initial() : users.first;
    } on FirebaseException catch (_) {
      networkResponse.errorText =
          "Error :(  on FirebaseException catch (_) getUserByUuId ";
    } catch (_) {
      // debugPrint(_.toString());
      networkResponse.errorText = "Error :( catch (_) getUserByUuId ";
    }

    return networkResponse;
  }
}
