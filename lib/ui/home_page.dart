import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_firebase/bloc/sample_bloc.dart';
import 'package:flutter_state_firebase/model/sample_model.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({this.uid});
  final String uid;
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<MyHomePage> {

   //_NotesState({this.uid});
  //final String uid;

  final sampleBloc = SampleBloc(uid);

  static String uid;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Center(child: Text("RxDart Crud")),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("todos").snapshots(),
        //stream: sampleBloc.dataStream,
        builder: (context,AsyncSnapshot<dynamic> snapshots){
          if(snapshots.data == null)
            return Center(
                child: Text("No notes", style: TextStyle(color: Colors.grey),));

          //SampleModel sampleApiData = snapshots.data.documentReference;
          return  ListView.builder(
              //shrinkWrap:true,
              itemCount: snapshots.data.docs.length,
              itemBuilder: (context, index) {
                 DocumentSnapshot documentSnapshot = snapshots.data.docs[index];

                return Dismissible(
                    onDismissed: (direction){
                      sampleBloc.deleteTodos(documentSnapshot);
                    },
                    key: Key(documentSnapshot["todoTitle"]),
                    child: GestureDetector(
                      child: Card(
                        margin: EdgeInsets.all(8),
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          title: Text(documentSnapshot["todoTitle"],style: TextStyle(fontSize: 22.0),),
                          trailing: IconButton(icon: Icon(Icons.delete, color: Colors.red,),
                            onPressed: (){
                              sampleBloc.deleteTodos(documentSnapshot);
                              final snackBar = SnackBar(
                                content: Text(' Note Deleted'),);
                              Scaffold.of(context).showSnackBar(snackBar);
                            },
                          ),
                        ),
                      ),
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                title: Text("Edit Note",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                content: TextField(
                                  onChanged: (String value) {
                                    sampleBloc.todoTitle = value;
                                  },
                                ),
                                actions: [
                                  FlatButton(
                                    onPressed: () {
                                      sampleBloc.editTodos(documentSnapshot);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Save" ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  ),
                                  FlatButton(
                                    onPressed:(){
                                      Navigator.of(context).pop();
                                    },
                                    child:  Text("Cancel",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),)
                                ],
                              );
                            });
                      },

                    ),
                  );
              });
        },),
      floatingActionButton: FloatingActionButton (
        onPressed: () async{
          //await sampleBloc.createTodos();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  title: Text("Add New Note",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  content: TextField(
                    onChanged: (String value) {
                      sampleBloc.todoTitle = value;
                    },
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        sampleBloc.createTodos();
                        Navigator.of(context).pop();
                      },
                      child: Text("Add" ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                    FlatButton(
                      onPressed:(){
                        Navigator.of(context).pop();
                      },
                      child:  Text("Cancel",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),)
                  ],
                );
              });
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
      // body: new Center(
      //   child: new Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       new StreamBuilder(
      //           stream: _counterBloc.counterObservable,
      //           builder: (context,snapshot){
      //             return new Text('${snapshot.data}', style: Theme.of(context).textTheme.headline4);
      //           })
      //     ],
      //   ),
      // ),
      // body: Container(
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   child: StreamBuilder(
      //     stream: sampleBloc.dataFromAPIStream,
      //     builder: (context, AsyncSnapshot<APIResponseModel> snapshot) {
      //       if (!snapshot.hasData) {
      //         return Center(
      //           child: JumpingText(
      //             'Press Button To Get Data!!!!',
      //             style: TextStyle(fontSize: 18),
      //           ),
      //         );
      //       }
      //       SampleModel sampleApiData = snapshot.data.response;
      //       return ListView.builder(
      //           itemCount: sampleApiData.listOfSample.length,
      //           itemBuilder: (context, int index) {
      //             return Column(
      //               children: [
      //                 Text(sampleApiData.listOfSample[index].title),
      //                 Divider(),
      //               ],
      //             );
      //           });
      //     },
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await sampleBloc.getData();
      //   },
      //   child: Icon(Icons.download_rounded),
      // ),
    );
  }
}
