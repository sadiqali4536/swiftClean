import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signIn(BuildContext context, String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );

      if (context.mounted) {
        Future.microtask(() {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Login Successful!"),
            backgroundColor: Colors.black,
          ));
        });
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Future.microtask(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Error: ${e.message}"),
            backgroundColor: Colors.red,
          ));
        });
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
    return null;
  }

  Future<UserCredential?> createUser(BuildContext context, String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );

      if (context.mounted) {
        Future.microtask(() {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Registration Successful"),
            backgroundColor: Colors.black,
          ));
        });
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Future.microtask(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Error: ${e.message}"),
            backgroundColor: Colors.red,
          ));
        });
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
    return null;
  }

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return 'Sign-in aborted by user';
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return 'FirebaseAuthException: ${e.message}';
    } catch (e) {
      return 'Exception during sign-in: $e';
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();

    if (context.mounted) {
      Future.microtask(() {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Logout Successful!"),
          backgroundColor: Colors.black,
        ));
      });
    }
  }
}
