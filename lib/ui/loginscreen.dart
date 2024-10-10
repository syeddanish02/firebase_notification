import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_task_office/ui/firestorescreen.dart';
import 'package:firebase_task_office/ui/postscreen.dart';
import 'package:firebase_task_office/ui/sinup_screen.dart';
import 'package:firebase_task_office/utils/utils.dart';
import 'package:firebase_task_office/widget/roundbutton.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _loginState();
}

class _loginState extends State<Loginscreen> {
final formkey= GlobalKey<FormState>();
 bool loading=false;
  FirebaseAuth auth=FirebaseAuth.instance;
  TextEditingController emailcontroler =TextEditingController();
  TextEditingController passwordcontroler =TextEditingController();

  void despose(){
super.dispose();

emailcontroler.dispose();
passwordcontroler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                SizedBox(height: 20,),
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
                  titile: 'Login',onTap: (){
                    //logins();
                  if(formkey.currentState!.validate()){
                    logins();

                  }
                },),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dont have an account'),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>signup()));
                    }, child: Text("signup"))

                  ],
                )



              ],
            ),
          ),
        ),
      ),
    );
  }
  void logins(){
    setState(() {
      loading=true;

    });
    auth.signInWithEmailAndPassword(email: emailcontroler.text.toString(), password: passwordcontroler.text.toString()).then((value){
      setState(() {
        loading=true;

      });
utils().showToast(value.user!.email.toString());
Navigator.push(context, MaterialPageRoute(builder: (context)=>Firestorescreen()));
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      utils().showToast(error.toString());
      setState(() {
        loading=false;
      });
    });
  }
  }

