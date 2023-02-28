import 'package:firebase_core/firebase_core.dart';
import 'package:firebaselearner/screens/home_screen.dart';
import 'package:firebaselearner/screens/login_screen.dart';
import 'package:firebaselearner/screens/register_screen.dart';
import 'package:firebaselearner/services/auth_services.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: AuthServices().firebaseAuth.authStateChanges(),
        builder: (context,snapshot){
          print(snapshot.data);
          if(snapshot.hasData){
            return HomeScreen();
          }
          return RegisterScreen();
        },
      ),
    );
  }
}


