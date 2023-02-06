import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterParams {
  final String userName;
  final String phone;
  final String email;
  final String password;

  RegisterParams({
    required this.userName,
    required this.phone,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
        'userName': userName,
        'phone': phone,
        'email': email,
        'password': password,
        'timestamp': Timestamp.now(),
      };
}
