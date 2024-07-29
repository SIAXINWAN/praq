import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:praq_try/services/firestoreService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register {
  final String name;
  final String icno;
  final String email;
  final String school;
  final String address;
  String? photo;
  String? id;

  Register(
      {
      this.photo,
      this.id,
      required this.name,
      required this.icno,
      required this.email,
      required this.school,
      required this.address});

  static Future<Register?>registerEvent(
    Register register, File image
  )async{
    String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
    UploadTask uploadTask =
        FirebaseStorage.instance.ref(fileName).putFile(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    register.photo = downloadURL;

    var newDriver = await FirestoreService.addRegister(register);
    if (newDriver == null) return null;

    return newDriver;
  }

  static Future<String> saveImage(File image) async {
    String fileName = 'register/${DateTime.now().microsecondsSinceEpoch}.jpg';
    UploadTask uploadTask =
        FirebaseStorage.instance.ref(fileName).putFile(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
        photo: json['photo'] ?? '',
        name: json['name'] ?? '',
        icno: json['icno'] ?? '',
        email: json['email'] ?? '',
        school: json['school'] ?? '',
        address: json['address'] ?? '');
  }

  toJson() {
    return {
      'photo': photo,
      'id': id,
      'name': name,
      'icno': icno,
      'email': email,
      'school': school,
      'address': address
    };
  }
}
