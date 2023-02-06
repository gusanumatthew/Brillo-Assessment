import 'package:brilloconnetz_test/src/core/routes.dart';
import 'package:brilloconnetz_test/src/core/utils/enums.dart';
import 'package:brilloconnetz_test/src/features/authentication/model/register_params.dart';
import 'package:brilloconnetz_test/src/features/authentication/view_model/register_state.dart';
import 'package:brilloconnetz_test/src/repositories/auth_repository.dart';
import 'package:brilloconnetz_test/src/services/failure.dart';
import 'package:brilloconnetz_test/src/services/navigation_service.dart';
import 'package:brilloconnetz_test/src/services/snackbar_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier(this._ref) : super(RegisterState.initial());
  final Ref _ref;

// this handles the color changes in the interest lists, since we don't have an endpoints with interest name , the id and color so we handle them on user interaction.
  void updatePress(int id) {
    List<int> pressColor = state.pressColor;
    pressColor.clear();

    if (pressColor.contains(id)) {
      pressColor.removeWhere((value) => value == id);
    } else {
      pressColor.add(id);
    }

    state = state.copyWith(pressColor: state.pressColor);
  }

//we need to know the selected interests, in other to use call them
//in the profile screen as instructed.
  void updateSelectedInterest(int id) {
    List<int> selectedInterest = state.selectedInterest;
    if (selectedInterest.contains(id)) {
      selectedInterest.removeWhere((value) => value == id);
    } else {
      selectedInterest.add(id);
    }

    state = state.copyWith(selectedInterest: selectedInterest);
  }

  Future<void> registerUser({required RegisterParams params}) async {
    state = state.copyWith(registerLoadState: LoadState.loading);
    try {
      await _ref
          .read(authenticationRepository)
          .registerRepository(params: params);
      _ref
          .read(snackbarService)
          .showSuccessSnackBar('Account Successfully created');
      _ref
          .read(navigationService)
          .navigateOffAllNamed(Routes.verifyEmail, (_) => false);
      state = state.copyWith(registerLoadState: LoadState.success);
    } on Failure catch (ex) {
      _ref.read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.copyWith(registerLoadState: LoadState.idle);
    }
  }
}

final registerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  return RegisterNotifier(ref);
});
