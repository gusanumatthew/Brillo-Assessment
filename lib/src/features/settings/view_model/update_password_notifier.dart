import 'package:brilloconnetz_test/src/core/utils/enums.dart';
import 'package:brilloconnetz_test/src/features/settings/view_model/update_password_state.dart';
import 'package:brilloconnetz_test/src/repositories/auth_repository.dart';
import 'package:brilloconnetz_test/src/services/failure.dart';
import 'package:brilloconnetz_test/src/services/navigation_service.dart';
import 'package:brilloconnetz_test/src/services/snackbar_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdatePasswordNotifier extends StateNotifier<UpdatePasswordState> {
  final Ref _ref;
  UpdatePasswordNotifier(this._ref) : super(UpdatePasswordState.initial());

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    state = state.copyWith(updatePasswordLoadState: LoadState.loading);

    try {
      await _ref.read(authenticationRepository).updatePassword(
            oldPassword: oldPassword,
            newPassword: newPassword,
          );

      _ref.read(navigationService).navigateBack();

      _ref
          .read(snackbarService)
          .showSuccessSnackBar('Password Update Successful');
    } on Failure catch (ex) {
      _ref.read(navigationService).navigateBack();

      _ref.read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.copyWith(updatePasswordLoadState: LoadState.idle);
    }
  }
}

final updatePasswordNotifierProvider = StateNotifierProvider.autoDispose<
    UpdatePasswordNotifier, UpdatePasswordState>(
  (ref) => UpdatePasswordNotifier(ref),
);
