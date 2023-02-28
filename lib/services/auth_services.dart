
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearner/screens/register_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthServices{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Register User
  Future<User?> resigerUser(String email,String password,BuildContext context) async{

    try{
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.redAccent,));
    }
    catch(e){
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong try again later"),backgroundColor: Colors.redAccent,));
    }

  }

  //Login User

  Future<User?> login(String email,String password,BuildContext context) async{
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.redAccent,));
    }
    catch(e){
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong try again later"),backgroundColor: Colors.redAccent,));
    }
  }

  Future<User?> signInWithGoogle() async{


    try{
      // trigger the authentication dialog
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser != null){
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        // Once signed in return the user data from firebase
        UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
        return userCredential.user;
    }}catch(e){
      print(e);
    }

  }

  Future signOut() async{
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }



}