import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_task_office/services/notification_services.dart';
import 'package:firebase_task_office/ui/firestore_add_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_task_office/ui/addpost.dart';
import 'package:firebase_task_office/ui/loginscreen.dart';
import 'package:firebase_task_office/utils/utils.dart';
import 'package:flutter/material.dart';

class Firestorescreen extends StatefulWidget {
  const Firestorescreen({super.key});

  @override
  State<Firestorescreen> createState() => _FirestorescreenState();
}

class _FirestorescreenState extends State<Firestorescreen> {
  final editcontroler=TextEditingController();
  final searchfilter=TextEditingController();
  final auth=FirebaseAuth.instance;
  final fireStore=FirebaseFirestore.instance.collection('user').snapshots();
  CollectionReference ref= FirebaseFirestore.instance.collection('user');
  notifications notification=notifications();
  //final ref=FirebaseDatabase.instance.ref('Post');
  @override
  void initState() {
    notification.firebaseinit();
    notification.requestnotificationPermission();
    notification.getDeviceToken().then((value){
     print('device token: $value');
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              auth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginscreen()));

            }, icon: Icon(Icons.logout))

          ],
          title: Text('Firestore_post'),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>addpost_firestore()));

        },
          child: Icon(Icons.add),),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            StreamBuilder<QuerySnapshot>(stream: fireStore, builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              if(snapshot.hasError){
                print('error accurd');
              }
             return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          onTap: (){
                            ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                          },
                          title: Text(snapshot.data!.docs[index]['title'].toString()),
                          subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                        );
                      }) );

            }),



          ],),
        ),

      ),
    );
  }
  Future<void>showmyDialoge(String title,String id)async{
    editcontroler.text=title;
    return showDialog(context: context, builder: (context){

      return AlertDialog(
        title:Text('update'),
        content: Container(
          child: TextFormField(
            controller: editcontroler,
            decoration: InputDecoration(
                hintText: 'edit here'
            ),

          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);

          }, child: Text('update')),
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('cancel')),

        ],
      );

    });
  }
}
