import 'package:brilloconnetz_test/src/core/utils/enums.dart';
import 'package:brilloconnetz_test/src/features/settings/view_model/update_profile_state.dart';
import 'package:brilloconnetz_test/src/repositories/auth_repository.dart';
import 'package:brilloconnetz_test/src/services/failure.dart';
import 'package:brilloconnetz_test/src/services/navigation_service.dart';
import 'package:brilloconnetz_test/src/services/snackbar_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdateProfileNotifier extends StateNotifier<UpdateProfileState> {
  final Ref _ref;
  UpdateProfileNotifier(this._ref) : super(UpdateProfileState.initial());

  Future<void> updateProfile(String userName) async {
    state = state.copyWith(updateProfileLoadState: LoadState.loading);

    try {
      await _ref.read(authenticationRepository).updateUser(userName: userName);

      _ref.read(navigationService).navigateBack();

      _ref
          .read(snackbarService)
          .showSuccessSnackBar('Profile Update Successful');
    } on Failure catch (ex) {
      _ref.read(navigationService).navigateBack();

      _ref.read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.copyWith(updateProfileLoadState: LoadState.idle);
    }
  }
}

final updateProfileNotifierProvider = StateNotifierProvider.autoDispose<
    UpdateProfileNotifier, UpdateProfileState>(
  (ref) => UpdateProfileNotifier(ref),
);
