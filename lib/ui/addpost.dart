import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_task_office/utils/utils.dart';
import 'package:firebase_task_office/widget/roundbutton.dart';
import 'package:flutter/material.dart';

class addpost extends StatefulWidget {
  const addpost({super.key});

  @override
  State<addpost> createState() => _addpostState();
}

class _addpostState extends State<addpost> {
  final posteditingControler=TextEditingController();
  bool loading =false;
  final firebaseRef= FirebaseDatabase.instance.ref('Post');
  void dispose(){
    super.dispose();
    posteditingControler.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 60,),
            TextFormField(
              controller: posteditingControler,

              maxLines:4,
              decoration: InputDecoration(

                hintText: 'what is in your mind',
        border: OutlineInputBorder(),

              ),
            ),
            SizedBox(height: 30,),
            roundButton(
              loading: loading,
                titile: 'add', onTap: (){
                setState(() {
                  loading=true;
                });
                final id=DateTime.now().millisecondsSinceEpoch.toString();
              firebaseRef.child(id).set({
                'tittle' : posteditingControler.text.toString(),
                'id': id,
              }).then((value){
                setState(() {
                  loading=false;
                });

                utils().showToast('post added');


              }).onError((error,StackTrace){
                setState(() {
                  loading=false;
                });

                utils().showToast(error.toString());

              });

            })

          ],
        ),
      ),
    );
  }
  Future<void>showmyDialoge()async{
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title:Text('update'),
        content: Container(
          child: TextFormField(

          ),
        ),
      );

    });
    }

  }

