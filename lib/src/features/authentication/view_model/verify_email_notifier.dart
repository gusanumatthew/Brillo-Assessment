import 'package:brilloconnetz_test/src/core/routes.dart';

import 'package:brilloconnetz_test/src/repositories/auth_repository.dart';
import 'package:brilloconnetz_test/src/services/navigation_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VerifyEmailNotifier extends StateNotifier<void> {
  final Ref _ref;
  VerifyEmailNotifier(this._ref) : super(null);

  Future<void> navigateToLogin() async {
    await _ref.read(authenticationRepository).signOut();

    _ref.read(navigationService).navigateOffNamed(Routes.login);
  }
}

final verifyEmailNotifierProvider =
    StateNotifierProvider.autoDispose<VerifyEmailNotifier, void>(
  (ref) => VerifyEmailNotifier(ref),
);
