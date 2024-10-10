import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_task_office/ui/addpost.dart';
import 'package:firebase_task_office/ui/loginscreen.dart';
import 'package:firebase_task_office/utils/utils.dart';
import 'package:flutter/material.dart';

class Postscreen extends StatefulWidget {
  const Postscreen({super.key});

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  final editcontroler=TextEditingController();
  final searchfilter=TextEditingController();
  final auth=FirebaseAuth.instance;
  final ref=FirebaseDatabase.instance.ref('Post');
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
          title: Text('post'),
        ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>addpost()));

      },
      child: Icon(Icons.add),),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            TextFormField(
              controller: searchfilter,
              decoration: InputDecoration(
                hintText: 'search',
                border: OutlineInputBorder(),

              ),
              onChanged: (String value){
                setState(() {

                });

              },
            ),

            Expanded(
                child:FirebaseAnimatedList(
                  defaultChild:Text('loading'),
                query: ref,
                itemBuilder: (contex,snapshot,index,animation){
                    final id =snapshot.child('id').value.toString();
                    final title=snapshot.child('tittle').value.toString();
                    if(searchfilter.text.isEmpty){
                      return ListTile(
                        title: Text(snapshot.child('tittle').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                            itemBuilder: (context)=>[
                              PopupMenuItem(
                                value:1,
                                  child: ListTile(
                                trailing: Icon(Icons.edit),
                                title: Text('Edit'),
                                    onTap: (){
                                  Navigator.pop(context);
                                  showmyDialoge(title,id);
                                    },

                              )),
                              PopupMenuItem(
                                value: 2,
                                  child: ListTile(
                                trailing: Icon(Icons.delete),
                                title: Text('Delete'),
                                    onTap: (){
                                  Navigator.pop(context);
                                  ref.child(snapshot.child('id').value.toString()).remove().then((value){
                                    utils().showToast('deleted');
                                  }).onError((Error,StackTrace){
                                    utils().showToast(Error.toString());
                                  });
                                    },

                              )),

      ]
                        ),
                      );

                    }else if (title.toLowerCase().contains(searchfilter.text.toLowerCase().toString())){
                      return ListTile(
                        title: Text(snapshot.child('tittle').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                        trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (context)=>[
                              PopupMenuItem(
                                  value:1,
                                  child: ListTile(
                                    trailing: Icon(Icons.edit),
                                    title: Text('Edit'),
                                    onTap: (){
                                      Navigator.pop(context);
                                      showmyDialoge(title,id);
                                    },

                                  )),
                              PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    trailing: Icon(Icons.delete),
                                    title: Text('Delete'),

                                  )),

                            ]
                        ),

                      );
                    }else{
                      return Container();

                    }



            }) )
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
            ref.child(id).update({
              'tittle': editcontroler.text.toString()
            }).then((value){
              utils().showToast('updated');

            }).onError((error, StackTrace){
              utils().showToast(error.toString());
            });
          }, child: Text('update')),
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('cancel')),

        ],
      );

    });
  }
}

// Expanded(child: StreamBuilder(stream: ref.onValue, builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
// if(!snapshot.hasData){
// return CircularProgressIndicator();
// }else{
// Map<dynamic, dynamic>map=snapshot.data!.snapshot.value as dynamic;
// List<dynamic> list=[];
// list.clear();
// list=map.values.toList();
//
// return ListView.builder(
// itemCount: snapshot.data!.snapshot.children.length,
// itemBuilder: (context, index){
// return ListTile(
// title: Text(list[index]['tittle']),
// subtitle: Text(list[index]['id'].toString() ),
//
// );
//
// },
// );
//
//
// }
//
//
// })),