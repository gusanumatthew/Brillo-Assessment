import 'package:brilloconnetz_test/src/core/utils/enums.dart';

class ForgotPasswordState {
  final LoadState forgetLoadState;

  ForgotPasswordState({required this.forgetLoadState});

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(forgetLoadState: LoadState.idle);
  }

  ForgotPasswordState copyWith({LoadState? forgetLoadState}) {
    return ForgotPasswordState(
        forgetLoadState: forgetLoadState ?? this.forgetLoadState);
  }
}
