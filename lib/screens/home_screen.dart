import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
        centerTitle: true,
        actions: [
          TextButton.icon(onPressed: (){}, icon: const Icon(Icons.exit_to_app,size: 30,), label: const Text("Sign out",style: TextStyle(fontSize: 15),),style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.white))),
        ],
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}
