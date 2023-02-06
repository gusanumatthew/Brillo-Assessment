import 'package:brilloconnetz_test/src/features/authentication/model/register_params.dart';
import 'package:brilloconnetz_test/src/features/profile/model/app_user.dart';
import 'package:brilloconnetz_test/src/repositories/user_repository.dart';
import 'package:brilloconnetz_test/src/services/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

class AuthenticationRepository {
  final Ref _ref;

  AuthenticationRepository(this._ref);
  User? get currentUser => FirebaseAuth.instance.currentUser;

//Register
  Future<AppUser> registerRepository({
    required RegisterParams params,
  }) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: params.email, password: params.password);
      await credential.user!.updateDisplayName(params.userName);
      await _ref
          .read(userRepository)
          .createUserWithId(credential.user!.uid, params: params);

      await credential.user!.sendEmailVerification();
      //with firebase email verification would be surely sent, check your spam if you didn't see the verification link.

      return _ref.read(userRepository).getFutureUser(credential.user!.uid);
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }

//Sign in
  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!credential.user!.emailVerified) {
        await FirebaseAuth.instance.signOut();
        throw const Failure('Email is not verified');
      }
      return _ref.read(userRepository).getFutureUser(credential.user!.uid);
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }

  Future<void> resetPassword(String emailAddress) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }

//Sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> updateUser({required String userName}) async {
    try {
      await currentUser!.updateDisplayName(userName);
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }

  Future<void> updateEmail({
    required String newEmailAddress,
    required String password,
  }) async {
    try {
      final AuthCredential authCredential = EmailAuthProvider.credential(
        email: currentUser!.email!,
        password: password,
      );

      await currentUser?.reauthenticateWithCredential(authCredential);

      await currentUser?.updateEmail(newEmailAddress);

      await currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final AuthCredential authCredential = EmailAuthProvider.credential(
        email: currentUser!.email!,
        password: oldPassword,
      );

      await currentUser?.reauthenticateWithCredential(authCredential);

      await currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }
}

final authenticationRepository = Provider(
  (ref) => AuthenticationRepository(ref),
);
