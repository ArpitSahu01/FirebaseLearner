
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> register(String email,String password) async{
    UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return user.user;
  }
}