import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_state_firebase/apiProvider/repository.dart';
import 'package:flutter_state_firebase/model/sample_model.dart';
import 'package:rxdart/rxdart.dart';

class SampleBloc {
  //final _repository = Repository();
  final _data = BehaviorSubject<dynamic>();
  final String uid;
  String todoTitle = '';

  SampleBloc(this.uid);

  Observable<dynamic> get dataStream => _data.stream;

  // Future<void> getData() async {
  //   final apiData = await _repository.getDataFromAPI();
  //   _dataFromAPI.sink.add(apiData);
  // }

  createTodos() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection("todos").doc(uid);
    Map<String, String> todos = {"todoTitle": todoTitle,"uid":uid};
    _data.sink.add(todos);
    documentReference.set(todos).whenComplete(() => print("Created"));
  }

  deleteTodos(DocumentSnapshot item) {
    FirebaseFirestore.instance.collection('todos').doc(item.id).delete().then((value) => print('Item Deleted'));
    _data.sink.add(item);
  }

  editTodos(DocumentSnapshot documentSnapshot) async {

    DocumentReference documentReference = FirebaseFirestore.instance.collection("todos").doc(documentSnapshot.id);
    Map<String, String> todos = {"todoTitle": todoTitle,"uid":uid};
    await documentReference.update({
      "todoTitle": todoTitle,"uid":uid,
    }).then((documentReference) {
      // Navigator.pop(context);
      print("Note Edited");
    }).catchError((e) {
      print(e);
    });
    _data.sink.add(todos);
  }

  disponse() {
    _data.close();
  }
}
