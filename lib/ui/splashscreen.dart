


import 'package:flutter/material.dart';

import '../services/splash_services.dart';



class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  splashservices splashScreen=splashservices();
  @override
  void initState() {
    super.initState();
    // Initialize anything you need here
    splashScreen.islogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body:Center(
          child: Text('splash screen'),
        )
    );
  }
}
