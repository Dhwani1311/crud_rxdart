// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_state_firebase/model/sample_model.dart';
// import 'package:flutter_state_firebase/model/sample_model.dart';
// import 'package:http/http.dart' as http;
//
// class SampleAPI {
//   //final String uid;
//   //String todoTitle = "";
//
//   Future<APIResponseModel> getDataFromAPI() async {
//     final reponse =
//         await http.get('https://jsonplaceholder.typicode.com/posts');
//     if (reponse.statusCode == 200) {
//       final data = jsonDecode(reponse.body);
//       return APIResponseModel(
//           statusCode: reponse.statusCode,
//           message: 'Data Found',
//           response: SampleModel.fromJSon(data));
//     } else {
//       return APIResponseModel(
//           response: [],
//           message: 'No Data Found',
//           statusCode: reponse.statusCode);
//     }
//   }
//
//   // createTodos() {
//   //   DocumentReference documentReference = FirebaseFirestore.instance.collection("users").doc(uid);
//   //   Map<String, String> todos = {"todoTitle": todoTitle,"uid":uid};
//   //
//   //   documentReference.set(todos).whenComplete(() => print("Created"));
//   // }
//   //
//   //  deleteTodos(DocumentSnapshot item) {
//   //   FirebaseFirestore.instance.collection('users').doc(item.id).delete().then((value) => print('Item Deleted'));
//   // }
//   //
//   //  editTodos(DocumentSnapshot documentSnapshot) async {
//   //
//   //   DocumentReference documentReference = FirebaseFirestore.instance.collection("users").doc(documentSnapshot.id);
//   //   Map<String, String> todos = {"todoTitle": todoTitle,"uid":uid};
//   //   await documentReference.update({
//   //     "todoTitle": todoTitle,"uid":uid,
//   //   }).then((documentReference) {
//   //     // Navigator.pop(context);
//   //     print("Note Edited");
//   //   }).catchError((e) {
//   //     print(e);
//   //   });
//   // }
//
// }
