import 'package:brilloconnetz_test/src/core/routes.dart';
import 'package:brilloconnetz_test/src/core/utils/enums.dart';
import 'package:brilloconnetz_test/src/features/authentication/view_model/login_state.dart';
import 'package:brilloconnetz_test/src/repositories/auth_repository.dart';
import 'package:brilloconnetz_test/src/repositories/user_repository.dart';
import 'package:brilloconnetz_test/src/services/failure.dart';
import 'package:brilloconnetz_test/src/services/navigation_service.dart';
import 'package:brilloconnetz_test/src/services/snackbar_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this._ref) : super(LoginState.initial());
  final Ref _ref;

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(loginLoadState: LoadState.loading);
    try {
      await _ref.read(authenticationRepository).login(
            email: email,
            password: password,
          );

      final user = _ref.read(authenticationRepository).currentUser;
      final appUser = await _ref.read(userRepository).getFutureUser(user!.uid);
      _ref
          .read(navigationService)
          .navigateOffNamed(Routes.dashboard, arguments: appUser);
    } on Failure catch (ex) {
      _ref.read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.copyWith(loginLoadState: LoadState.idle);
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref);
});
