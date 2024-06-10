import 'package:cloud_firestore/cloud_firestore.dart';
import 'model_class.dart';


Future<Orders?> fetchOrderDetails(String uid) async {
  var doc = FirebaseFirestore.instance.collection('Orders').doc(uid);
  var snapshot = await doc.get();
  if (snapshot.exists) {
    return Orders.fromFirestore(snapshot.data()!, snapshot.id);
  } else{
    return null;
  }
}
