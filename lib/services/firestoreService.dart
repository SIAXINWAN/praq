import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:praq_try/model/register.dart';

class FirestoreService {
  static final firestore = FirebaseFirestore.instance;

  static Future<Register?> addRegister(Register register) async {
    try {
      var collection = await firestore.collection('register').get();
      register.id = 'R${collection.size + 1}';
      var doc = firestore.collection('register').doc(register.id);
      doc.set(register.toJson());
       var driverDoc =
          await firestore.collection('register').doc(register.id).get();

      Map<String, dynamic> data = driverDoc.data() as Map<String, dynamic>;
      Register newDriver = Register.fromJson(data);
      return newDriver;
      
    } catch (e) {
      return null;
    }
  }
}
