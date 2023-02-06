import 'package:brilloconnetz_test/src/core/utils/enums.dart';
import 'package:brilloconnetz_test/src/features/authentication/view_model/forgot_password_state.dart';
import 'package:brilloconnetz_test/src/repositories/auth_repository.dart';
import 'package:brilloconnetz_test/src/services/failure.dart';
import 'package:brilloconnetz_test/src/services/navigation_service.dart';
import 'package:brilloconnetz_test/src/services/snackbar_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordNotifier(this._ref) : super(ForgotPasswordState.initial());
  final Ref _ref;

  Future<void> resetPassword(String emailAddress) async {
    state = state.copyWith(forgetLoadState: LoadState.loading);

    try {
      await _ref
          .read(authenticationRepository)
          .resetPassword(emailAddress.trim());

      _ref.read(navigationService).navigateBack();

      _ref.read(snackbarService).showSuccessSnackBar(
            'Instructions to reset your password has been sent to your email',
          );
    } on Failure catch (ex) {
      _ref.read(navigationService).navigateBack();

      _ref.read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.copyWith(forgetLoadState: LoadState.idle);
    }
  }
}

final forgotPasswordNotifierProvider = StateNotifierProvider.autoDispose<
    ForgotPasswordNotifier, ForgotPasswordState>(
  (ref) => ForgotPasswordNotifier(ref),
);
