
import 'dart:async';
import 'dart:core';

import 'package:firebase_task_office/ui/firestorescreen.dart';
import 'package:firebase_task_office/ui/loginscreen.dart';
import 'package:firebase_task_office/ui/postscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class splashservices{
  void islogin(BuildContext context){
   final auth =FirebaseAuth.instance;
   final user=auth.currentUser;
   if(user!=null){
     Timer(Duration (seconds: 3),()=>
         Navigator.push(context, MaterialPageRoute(builder: (context)=>Firestorescreen())));
   }else{
     Timer(Duration (seconds: 3),()=>
         Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginscreen())));
   }

   }


    }