// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'model_class.dart';
//
//
// Future<Orders?> fetchOrderDetails(String uid) async {
//   var doc = FirebaseFirestore.instance.collection('Orders').doc(uid);
//   var snapshot = await doc.get();
//   if (snapshot.exists) {
//     return Orders.fromFirestore(snapshot.data()!, snapshot.id);
//   } else{
//     return null;
//   }
// }
//
//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model_class.dart';  // Ensure this points to your Order model

Future<List<Orders>> fetchAllOrders() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Orders').get();
  return querySnapshot.docs.map((doc) => Orders.fromFirestore(doc)).toList();
}

Future<Orders?> fetchOrderDetails(String orderId) async {
  DocumentSnapshot doc = await FirebaseFirestore.instance.collection('Orders').doc(orderId).get();
  if (doc.exists) {
    return Orders.fromFirestore(doc);
  } else {
    return null;
  }
}

