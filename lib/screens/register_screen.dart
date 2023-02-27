import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselearner/screens/login_screen.dart';
import 'package:firebaselearner/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
   RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
   bool isLoading = false;

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
                    onPressed: () async {
                    setState((){
                      isLoading = true;
                    });
                    try{
                      if (_emailController.text.isNotEmpty &&
                          _setPasswordController.text.isNotEmpty &&
                          _setPasswordController.text ==
                              _confirmPasswordController.text) {
                        User? user = await AuthService().register(_emailController.text, _setPasswordController.text);
                        if(user !=null){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully created user")));
                          print("Success");
                          print(user.email);
                        }
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter correct credentials")));
                      }
                    }catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong try again later")));
                    }finally{
                      setState(() {
                        isLoading= false;
                      });
                    }
                    },
                    child: isLoading ? const Center(child: CircularProgressIndicator(color: Colors.white),):const Text("SUBMIT",style: TextStyle(fontSize: 20),),
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
