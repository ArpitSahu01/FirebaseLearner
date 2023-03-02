
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService{
  FirebaseFirestore instance = FirebaseFirestore.instance;

  Future insertNote(String title,String description,String userId,BuildContext context) async{
    try{
      await instance.collection("notes").add({
        "title":title,
        "description":description,
        "date":DateTime.now(),
        "userId":userId,
      });
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong unable to add task")));
    }
  }

  Future updateNote(String docId,String title,String description) async{
    try{
      await instance.collection("notes").doc(docId).update({
        'title':title,
        'description':description,
      });
    }catch(e){

    }
  }

  Future deleteNote(String docId) async{
      try{
        await instance.collection("notes").doc(docId).delete();
      }catch(e){

      }
  }

}