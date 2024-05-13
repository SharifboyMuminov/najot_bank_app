import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/data/models/card/card_model.dart';
import 'package:untitled1/data/models/network_response.dart';
import 'package:untitled1/utils/app_contains.dart';

class CardRepository {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  Future<NetworkResponse> insertCard({required CardModel cardModel}) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      DocumentReference documentReference = await _firebaseFirestore
          .collection(AppConstants.userCardBaseName)
          .add(cardModel.toJson());

      await _firebaseFirestore
          .collection(AppConstants.userCardBaseName)
          .doc(documentReference.id)
          .update({"cardId": documentReference.id});
    } on FirebaseException catch (_) {
      networkResponse.errorText = "insertCard on FirebaseException catch (_)";
    } catch (_) {
      networkResponse.errorText = "insertCard  catch (_)";
    }

    return networkResponse;
  }

  Future<NetworkResponse> updateCard({required CardModel cardModel}) async {
    NetworkResponse networkResponse = NetworkResponse();

    await _firebaseFirestore
        .collection(AppConstants.userCardBaseName)
        .doc(cardModel.cardId)
        .update(cardModel.toJson());

    return networkResponse;
  }

  Stream<List<CardModel>> getCardByUserId({required String userId}) =>
      _firebaseFirestore
          .collection(AppConstants.userCardBaseName)
          .where("userId", isEqualTo: userId)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => CardModel.fromJson(e.data())).toList());

  Stream<List<CardModel>> getCardsData() => _firebaseFirestore
      .collection(AppConstants.cardBaseName)
      .snapshots()
      .map((event) =>
          event.docs.map((e) => CardModel.fromJson(e.data())).toList());

  Future<NetworkResponse> deleteCard({required CardModel cardModel}) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await _firebaseFirestore
          .collection(AppConstants.userCardBaseName)
          .doc(cardModel.cardId)
          .delete();
    } on FirebaseException catch (_) {
      networkResponse.errorText = "insertCard on FirebaseException catch (_)";
    } catch (_) {
      networkResponse.errorText = "insertCard  catch (_)";
    }

    return networkResponse;
  }
}
