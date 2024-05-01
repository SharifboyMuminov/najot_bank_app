import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled1/data/models/network_response.dart';

class AuthRepository {
  Future<NetworkResponse> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return NetworkResponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return NetworkResponse(
        errorText: "Login with Email and Password Failure: ${e.message}",
      );
    } catch (error) {
      // print("ERROR: ${error.toString()}");
      return NetworkResponse(
          errorText: "An unknown exception occurred: ${error}");
    }
  }

  Future<NetworkResponse> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return NetworkResponse(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return NetworkResponse(
        errorText: "Registration Failure: ${e.message}",
      );
    } catch (error) {
      return NetworkResponse(
          errorText: "An unknown exception occurred: ${error}");
    }
  }

  // Future<NetworkResponse> googleSignIn() async {
  //   try {
  //     GoogleSignIn googleSignIn = GoogleSignIn();
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //     if (googleUser != null) {
  //       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  //       return NetworkResponse(data: userCredential);
  //     } else {
  //       return NetworkResponse(errorText: "Google Sign-In Failed: No user selected");
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     return NetworkResponse(
  //       errorText: "Login with Google Failure: ${e.message}",
  //     );
  //   } catch (_) {
  //     return NetworkResponse(errorText: "An unknown exception occurred");
  //   }
  // }

  Future<NetworkResponse> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      return NetworkResponse(data: "success");
    } on FirebaseAuthException catch (e) {
      return NetworkResponse(
        errorText: "Sign Out Error: ${e.message}",
      );
    } catch (_) {
      return NetworkResponse(errorText: "An unknown exception occurred");
    }
  }
}
