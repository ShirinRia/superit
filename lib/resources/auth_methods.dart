import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:superit/models/user.dart' as model;
import 'package:superit/resources/storage_methods.dart';

import '../screens/otp_screen.dart';
import '../screens/user_information_screen.dart';
import '../utils/utils.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
    await _firestore.collection('users')
        .doc(currentUser.uid).get();

    return model.User.fromSnap(
       snap
    );
  }
  Future<void> signUpUserphone(BuildContext context, {
    required String phoneNumber,

  }) async {
    String res = "Some error Occurred";
    try {

      // registering user in auth with email and password
      ConfirmationResult cred = _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeAutoRetrievalTimeout: (String verificationId) {  },
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: ((String verificationId, int? resendToken) async {


          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>  OTPScreen(verificationId: verificationId),
            ),
          );
        }),

      ) as ConfirmationResult;


      res = "success";

    }

    catch (err) {
      res = err.toString();
    }

  }

  Future<void> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP}) async {
    String res = "Some error Occurred";


    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      print('success');
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   UserInformationScreen.routeName,
      //       (route) => false,
      // );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>   UserInformationScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context,  e.message!);
    }


    catch (err) {
      res = err.toString();
    }
    //return res;
  }
  // Signing Up User

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    //required String fullname,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

        model.User user = model.User
          (
          username: username,
          //fullname:fullname,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
        res = "success";
      }
    }
    // on FirebaseAuthException catch (err) {
    //   if (err.code == 'invalid-email') {
    //     res = "The email is badly formatted";
    //   }
    //   else if(err.code=='weak-password'){
    //     res = "Password should be at least 6 characters";
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }



// logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    }

    catch (err) {
      return err.toString();
    }
    return res;
  }
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
