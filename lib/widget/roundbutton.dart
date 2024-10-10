import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class roundButton extends StatelessWidget {
  const roundButton({super.key,required this.titile,required this.onTap,this.loading=false});
  final String titile;
  final VoidCallback onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {

    return  GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,

        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child:loading? CircularProgressIndicator(): Text(titile ,style: TextStyle(color: Colors.white),),

        ),
      ),
    );
  }
}
