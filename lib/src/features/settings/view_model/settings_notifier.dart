import 'package:brilloconnetz_test/src/core/routes.dart';
import 'package:brilloconnetz_test/src/features/settings/view_model/settings_state.dart';
import 'package:brilloconnetz_test/src/repositories/auth_repository.dart';
import 'package:brilloconnetz_test/src/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsNotifer extends StateNotifier<SettingState> {
  final Ref _ref;
  SettingsNotifer(this._ref) : super(SettingState.initial());

  User get user => _ref.read(authenticationRepository).currentUser!;

  Future<void> logoutUser() async {
    await _ref.read(authenticationRepository).signOut();

    _ref.read(navigationService).navigateOffAllNamed(
          Routes.login,
          (_) => false,
        );
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifer, SettingState>(
    (ref) => SettingsNotifer(ref));
