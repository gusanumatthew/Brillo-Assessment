import 'package:brilloconnetz_test/src/core/routes.dart';
import 'package:brilloconnetz_test/src/core/utils/enums.dart';
import 'package:brilloconnetz_test/src/features/settings/view_model/update_email_state.dart';
import 'package:brilloconnetz_test/src/repositories/auth_repository.dart';
import 'package:brilloconnetz_test/src/services/failure.dart';
import 'package:brilloconnetz_test/src/services/navigation_service.dart';
import 'package:brilloconnetz_test/src/services/snackbar_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdateEmailNotifier extends StateNotifier<UpdateEmailState> {
  UpdateEmailNotifier(this._ref) : super(UpdateEmailState.initial());

  final Ref _ref;

  Future<void> updateEmail(String emailAddress, String password) async {
    state = state.copyWith(updateEmailLoadState: LoadState.loading);

    try {
      await _ref.read(authenticationRepository).updateEmail(
            newEmailAddress: emailAddress,
            password: password,
          );

      _ref.read(navigationService).navigateOffAllNamed(
            Routes.verifyEmail,
            (_) => false,
          );

      _ref.read(snackbarService).showSuccessSnackBar(
            'Email Update Successful! Verify and Login Again',
          );
    } on Failure catch (ex) {
      _ref.read(navigationService).navigateBack();

      _ref.read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.copyWith(updateEmailLoadState: LoadState.idle);
    }
  }
}

final updateEmailNotifierProvider =
    StateNotifierProvider.autoDispose<UpdateEmailNotifier, UpdateEmailState>(
  (ref) => UpdateEmailNotifier(ref),
);
