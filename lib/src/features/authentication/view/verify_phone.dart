import 'package:flutter/material.dart';

class VerifyPhone extends StatelessWidget {
  const VerifyPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
// we won't be handling this, am using a backendless solution Firebase /creating user with firebase is either you create with email and password 
// or phone and password according to the available endpoints available.
// trust me it is possible to implement, but my registeration function is doing allot already and email verification is handled properly.
// would be much easier if we had our endpoints, then we can bend to our own use case.
// check line 27 to 36 in authentication repositories for better understanding.

