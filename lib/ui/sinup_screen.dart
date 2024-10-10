import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_task_office/ui/loginscreen.dart';
import 'package:firebase_task_office/ui/postscreen.dart';
import 'package:firebase_task_office/utils/utils.dart';
import 'package:firebase_task_office/widget/roundbutton.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool loading=false;
  FirebaseAuth auth=FirebaseAuth.instance;
  TextEditingController emailcontroler =TextEditingController();
  TextEditingController passwordcontroler =TextEditingController();
  final formkey= GlobalKey<FormState>();
  void despose(){


    emailcontroler.dispose();
    passwordcontroler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailcontroler,
                decoration: InputDecoration(
                  hintText: 'username',

                  prefixIcon: Icon(Icons.alternate_email),

                ) ,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter email';
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 10,),
              TextFormField(

                obscureText:true,
                controller: passwordcontroler,
                decoration: InputDecoration(
                  hintText: 'password',

                  prefixIcon: Icon(Icons.lock),

                ) ,
                validator: (value){
                  if(value!.isEmpty){
                    return 'password';
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 30,),
             roundButton(
               loading: loading,
                 titile: 'singin', onTap: (){

               if(formkey.currentState!.validate()){
                 signup();
               }

             }),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('already have an account?'),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginscreen()));
                  }, child: Text('login'))
                ],
              )



            ],
          ),
        ),
      ),
    );
  }
  void signup(){
    setState(() {
      loading=true;

    });
    auth.createUserWithEmailAndPassword(email: emailcontroler.text.toString(), password: passwordcontroler.text.toString()).then((value){

      setState(() {
        loading=false;
      });

    }).onError((error, stackTrace) {
     // debugPrint(error.toString());
      utils().showToast(error.toString());
      setState(() {
        loading=false;
      });
    });


  }
}

