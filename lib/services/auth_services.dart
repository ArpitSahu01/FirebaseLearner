
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Register User
  Future<User?> resigerUser(String email,String password) async{
    UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

}