import 'package:brilloconnetz_test/src/core/utils/enums.dart';

class LoginState {
  final LoadState loginLoadState;

  LoginState({required this.loginLoadState});

  factory LoginState.initial() {
    return LoginState(loginLoadState: LoadState.idle);
  }

  LoginState copyWith({LoadState? loginLoadState}) {
    return LoginState(loginLoadState: loginLoadState ?? this.loginLoadState);
  }
}
