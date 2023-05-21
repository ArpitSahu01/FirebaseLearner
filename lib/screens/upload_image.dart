import 'dart:math';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  bool isLoading = false;

  Future<void> uploadImage(String inputSource) async{
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: inputSource == 'camera'? ImageSource.camera:ImageSource.gallery);

    if(pickedImage == null){
      return null;
    }

    String fileName = pickedImage.name;
    File imageFile = File(pickedImage.path);

    try{
      setState(() {
        isLoading = true;
      });
      await firebaseStorage.ref(fileName).putFile(imageFile);
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully uploaded')));
    }on FirebaseException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
    }catch(errror){
      print(errror);
    }
  }

  Future<List> loadImages() async{
   List<Map> files = [];
   final ListResult result = await firebaseStorage.ref().listAll();
   final List<Reference> allFiles = result.items;
   await Future.forEach(allFiles, (Reference file) async{
     final String fileUrl = await file.getDownloadURL();
     files.add({
       "url": fileUrl,
       "path":file.fullPath,
     });
   });
   print(files);
   return files;
  }

  Future<void> delete(String ref) async{
  await firebaseStorage.ref(ref).delete();
  setState(() {
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload to Firebase storage'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            isLoading? Center(child: CircularProgressIndicator(),) : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(onPressed: () {
                   uploadImage('camera');
                }, icon: Icon(Icons.camera), label: Text('Camera')),
                ElevatedButton.icon(onPressed: () {
                   uploadImage('gallery');
                }, icon: Icon(Icons.library_add), label: Text('Gallery')),
              ],
            ),
            SizedBox(height: 50,),
            Expanded(child: FutureBuilder(
              future: loadImages(),
              builder: (context,AsyncSnapshot snaphot){
                if(snaphot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                return ListView.builder(
                  itemCount: snaphot.data.length?? 0,
                    itemBuilder: (context,index){
                    final Map image = snaphot.data[index];
                    return Row(
                      children: [
                        Expanded(child: Card(
                          child: Container(
                            height: 200,
                            child: Image.network(image["url"]),
                          ),
                        )),
                        IconButton(onPressed: ()async{
                          await delete(image['path']);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image Deleted Successfully!')));
                        }, icon: Icon(Icons.delete,color: Colors.red,)),
                      ],
                    );
                });
              },
            )),
            
          ],
        ),
      ),
    );
  }
}
