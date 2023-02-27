import 'package:firebaselearner/screens/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _setPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
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
              const SizedBox(height: 10,),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
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
                    onPressed: (){},
                    child: const Text("SUBMIT",style: TextStyle(fontSize: 20),),
                ),
              ),
              const SizedBox(height: 5,),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>LoginScreen()));
              }, child: const Text('Already Have an account? Login here')),

            ],
        ),
         ),
      ),
    );
  }
}
