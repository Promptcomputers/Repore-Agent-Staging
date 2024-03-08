// import 'package:cloud_firestore/cloud_firestore.dart';

// final CollectionReference _configCollectionReference =
//     FirebaseFirestore.instance.collection("config");

// class DatabaseService {
//   Future<String> baseUrl() async {
//     var query = await _configCollectionReference.doc("base_url").get();

//     var a = query.data() as Map;
//     return a["production_url"];
//   }
// }
