import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearner/services/firestore_service.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  User? user;
  AddNoteScreen(this.user);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20,),
              Text("Description",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                minLines: 5,
                maxLines: 5,
              ),
              const SizedBox(height: 20,),
              isLoading ? Center(child: CircularProgressIndicator(),) : Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async{
                    if(titleController.text.isEmpty ||descriptionController.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter all the fields")));

                    }else{
                      setState(() {
                        isLoading = true;
                      });
                      await FirestoreService().insertNote(titleController.text, descriptionController.text, widget.user!.uid,context);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  child: Text('Add Note',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),),
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
