import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearner/services/auth_services.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _setPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height/1.5,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: _setPasswordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
                ),
              ),
              const SizedBox(height: 30,),
              Container(
                width: MediaQuery.of(context).size.width-50,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                  onPressed: () async{

                      if(_emailController.text.isNotEmpty && _setPasswordController.text.isNotEmpty){
                        User? user = await AuthServices().login(_emailController.text, _setPasswordController.text,context);
                        if(user != null){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully signIn"),backgroundColor: Colors.redAccent,));
                          print("User Email - ${user.email}");
                          print("User id - ${user.uid}");
                        }
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all the fields'),backgroundColor: Colors.redAccent,));
                      }


                  },
                  child: const Text("LOGIN",style: TextStyle(fontSize: 20),),
                ),
              ),
              const SizedBox(height: 5,),
              TextButton(onPressed: (){}, child: const Text('Already Have an account? Login here')),

            ],
          ),
        ),
      ),
    );
  }
}
