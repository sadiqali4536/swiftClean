// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:swiftclean_project/MVVM/model/models/user_model.dart';

// class FirebaseAuthServices {
//   // create auth as a instance
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final userId = FirebaseAuth.instance.currentUser?.uid;
//   final FirebaseFirestore dbUser= FirebaseFirestore.instance;

//   Future<UserCredential?> signIn(BuildContext context, String email, String password) async {
//     try {
//       UserCredential credential = await _auth.signInWithEmailAndPassword(
//         email: email, 
//         password: password,
//       );

      
//       return credential;
//     } on FirebaseAuthException catch (e) {
//       if (context.mounted) {
//         Future.microtask(() {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text("Error: ${e.message}"),
//             backgroundColor: Colors.red,
//           ));
//         });
//       }
//     } catch (e) {
//       debugPrint("Error: $e");
//     }
//     return null;
//   }

//   Future<User?> createUser(
//     BuildContext context,
//      String email,
//       String password,
//       String role,) async {
//     try {
//       UserCredential credential = await _auth.createUserWithEmailAndPassword(
//         email: email, 
//         password: password,
//       );

//     final user = credential.user;

//       if(user != null){
//        UserModel userData =UserModel(
//         createAt: FieldValue.serverTimestamp(),
//         email: _auth.currentUser!.email,
//         role: role,
//         phone: "",
//         address: "",
//         profileUrl: "",
//         uid: _auth.currentUser?.uid,
//         username: "",
//        );

//         await dbUser.collection('users').doc(_auth.currentUser?.uid).set(userData.toMap());
        
//       }

//       if (context.mounted) {
//         Future.microtask(() {
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text("Registration Successful"),
//             backgroundColor: Colors.black,
//           ));
//         });
//       }
//       return user;
//     } on FirebaseAuthException catch (e) {
//       if (context.mounted) {
//         Future.microtask(() {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text("Error: ${e.message}"),
//             backgroundColor: Colors.red,
//           ));
//         });
//       }
//     } catch (e) {
//       debugPrint("Error: $e");
//     }
//     return null;
//   }

//   Future<String> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       if (googleUser == null) {
//         return 'Sign-in aborted by user';
//       }

//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       await _auth.signInWithCredential(credential);
//       return 'Success';
//     } on FirebaseAuthException catch (e) {
//       return 'FirebaseAuthException: ${e.message}';
//     } catch (e) {
//       return 'Exception during sign-in: $e';
//     }
//   }

//   Future<void> signOut(BuildContext context) async {
//     await _auth.signOut();

//     if (context.mounted) {
//       Future.microtask(() {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text("Logout Successful!"),
//           backgroundColor: Colors.black,
//         ));
//       });
//     }
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:swiftclean_project/MVVM/model/models/user_model.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Sign in with Email and Password
  Future<UserCredential?> signIn(BuildContext context, String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error: \${e.message}"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      debugPrint("Error: \$e");
    }
    return null;
  }

  // Create User
  Future<User?> createUser(BuildContext context, String email, String password, String role) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = credential.user;

      if (user != null) {
        UserModel userData = UserModel(
          createAt: FieldValue.serverTimestamp(),
          email: user.email,
          role: role,
          phone: "",
          address: "",
          profileUrl: "",
          uid: user.uid,
          username: "",
        );

        await db.collection('users').doc(user.uid).set(userData.toMap());
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Registration Successful"),
          backgroundColor: Colors.black,
        ));
      }

      return user;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error: \${e.message}"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      debugPrint("Error: \$e");
    }
    return null;
  }

  // Google Sign In
  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return 'Sign-in aborted by user';

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return 'FirebaseAuthException: \${e.message}';
    } catch (e) {
      return 'Exception during sign-in: \$e';
    }
  }

  // Sign Out
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Logout Successful!"),
        backgroundColor: Colors.black,
      ));
    }
  }

  // Add item to cart
  Future<void> addToCart({
    required BuildContext context,
    required String serviceId,
    required String serviceName,
    required double price,
    required double originalPrice,
    required String imageUrl,
  }) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception("User not logged in");

      final cartData = {
        'userId': userId,
        'serviceId': serviceId,
        'serviceName': serviceName,
        'price': price,
        'originalPrice': originalPrice,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await db.collection('carts').add(cartData);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Service added to cart"), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add to cart: \$e"), backgroundColor: Colors.red),
        );
      }
    }
  }
}
