// class SampleModel {
//   SampleModel.fromJSon(dynamic toJson) {
//     if (toJson.isNotEmpty) {
//       toJson.forEach((element) => listOfSample.add(Sample.fromJSon(element)));
//     }
//   }
//
//   List<Sample> listOfSample = [];
// }
//
// class Sample {
//   Sample.fromJSon(Map<String, dynamic> toJson) {
//     userId = toJson['userId'];
//     id = toJson['id'];
//     title = toJson['title'];
//     body = toJson['body'];
//   }
//   int userId;
//   int id;
//   String title;
//   String body;
//
// }
//
// class APIResponseModel {
//   const APIResponseModel({this.statusCode, this.message, this.response});
//   final int statusCode;
//   final String message;
//   final dynamic response;
// }
