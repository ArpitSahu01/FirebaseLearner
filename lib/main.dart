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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: StreamBuilder(
        stream: AuthServices().firebaseAuth.authStateChanges().asBroadcastStream(),
        builder: (context,snapshot){
          if(snapshot.hasData ){
            return HomeScreen(snapshot.data);
          }
          return RegisterScreen();
        },
      ),
    );
  }
}


