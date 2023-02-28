import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearner/screens/add_note.dart';
import 'package:firebaselearner/screens/edit_note.dart';
import 'package:firebaselearner/services/auth_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  User? user;
  HomeScreen(this.user);

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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => AddNoteScreen(user)));
        },
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: [
          Card(
            color: Colors.teal,
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              title: Text("Build a new app ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
              subtitle: Text("This is an amazing app to start adding your daily task which neather complete ever in your life",overflow: TextOverflow.ellipsis,maxLines: 2,),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>EditNoteScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
