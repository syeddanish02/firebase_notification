import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_task_office/utils/utils.dart';
import 'package:firebase_task_office/widget/roundbutton.dart';
import 'package:flutter/material.dart';

class addpost_firestore extends StatefulWidget {
  const addpost_firestore({super.key});

  @override
  State<addpost_firestore> createState() => _addpost_firestoreState();
}

class _addpost_firestoreState extends State<addpost_firestore> {
  final posteditingControler=TextEditingController();
  bool loading =false;
 final fireStore=FirebaseFirestore.instance.collection('user');
  void dispose(){

    posteditingControler.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('firestore add'),
        centerTitle: true,
      ),
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
                titile: 'add', onTap: () {
              setState(() {
                loading = true;
              });
              String id = DateTime
                  .now()
                  .millisecondsSinceEpoch
                  .toString();
             fireStore.doc(id).set({
                'title': posteditingControler.text.toString(),
                'id': id
              }).then((value) {
                setState(() {
                  loading = false;
                });
                utils().showToast('firestore post added');
                posteditingControler.clear();
              }).onError((Error, StackTrace) {
                setState(() {
                  loading = false;
                });
                utils().showToast(Error.toString());
                print(Error);
              });

            }
            )

          ],
        ),
      ),
    );
  }


}

