import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaselearner/services/auth_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
        centerTitle: true,
        actions: [
          TextButton.icon(onPressed: () async{
            await AuthServices().signOut();
          }, icon: const Icon(Icons.exit_to_app,size: 30,), label: const Text("Sign out",style: TextStyle(fontSize: 15),),style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.white))),
        ],
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () async{
              CollectionReference users = firestore.collection('user');
              // await users.add({
              //   "name":"Arpit",
              // });
              await users.doc("user1").set({
                'name':'Robot',
              });
            }, child: Text("Add data to firestore")),

            ElevatedButton(onPressed: () async{
              CollectionReference user = firestore.collection('user');
              // QuerySnapshot allResult = await user.get();
              // allResult.docs.forEach((DocumentSnapshot result) {
              //     print(result.data());
              // });
              DocumentSnapshot result = await user.doc("user1").get();
              print(result.data());

              // user.doc("user1").snapshots().listen((result) {
              //   print(result.data());
              // });
            }, child: const Text('Read data from firestore')),
            ElevatedButton(onPressed: () async{
              await firestore.collection("user").doc("user1").update({"name":"Arpit"});
            }, child: Text("Update the data")),
            ElevatedButton(onPressed: () async{
              await firestore.collection("user").doc("user1").delete();
            }, child: Text("Delete the data")),
          ],
        ),
      ),
    );
  }
}
