import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uuid;
  String name;
  String gender;
  String? interedstedIn;
  String? photo;
  Timestamp age;
  GeoPoint? locantion;

  User(
      {required this.uuid,
      required this.name,
      required this.gender,
      this.interedstedIn,
      this.photo,
      required this.age,
      this.locantion});
}
