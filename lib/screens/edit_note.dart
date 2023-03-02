import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaselearner/models/note.dart';
import 'package:flutter/material.dart';

import '../services/firestore_service.dart';

class EditNoteScreen extends StatefulWidget {
  NoteModel note;
  EditNoteScreen(this.note);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {


  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.title;
    _descriptionController.text = widget.note.description;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () async{
            try{
              showDialog(context: context, builder: (BuildContext context){
                return AlertDialog(
                  title: Text("Please Confirm"),
                  content: Text('Are you sure to delete the note?'),
                  actions: [
                    // Yes Button
                    TextButton(onPressed: () async{
                      await FirestoreService().deleteNote(widget.note.id);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();

                    }, child: Text('Yes')),
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text('No')),
                  ],
                );
              });
              await FirestoreService().deleteNote(widget.note.id);
              Navigator.of(context).pop();
            }catch(e){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong not able to delete.")));
            }
          }, icon: Icon(Icons.delete,color: Colors.red ,)),
        ],
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
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Description",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
               TextField(
                 controller: _descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                minLines: 5,
                maxLines: 5,
              ),
              const SizedBox(height: 20,),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: isLoading? Center(child: CircularProgressIndicator(),) : ElevatedButton(
                  onPressed: () async{
                    if(_titleController.text.isEmpty||_descriptionController.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the fields")));

                    }else{
                      setState(() {
                        isLoading = true;
                      });
                      await FirestoreService().updateNote(widget.note.id, _titleController.text, _descriptionController.text);
                      Navigator.of(context).pop();
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  child: const Text('Update Note',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  ),
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
