import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearner/models/note.dart';
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("notes").where("userId",isEqualTo: user!.uid).snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){

              if(snapshot.data!.docs.length >0){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                NoteModel note =NoteModel.fromJson(snapshot.data!.docs[index]);
                return Card(
                  color: Colors.teal,
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    title: Text(note.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    subtitle: Text(note.description,overflow: TextOverflow.ellipsis,maxLines: 2,),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>EditNoteScreen()));
                    },
                  ),
                );
              });
              }
            }else{
              return Text('No data to show');
            }
            return Center(child: CircularProgressIndicator(),);
          }
      ),
    );
  }
}
