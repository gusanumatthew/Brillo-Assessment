import 'package:brilloconnetz_test/src/core/utils/enums.dart';

class UpdatePasswordState {
  final LoadState updatePasswordLoadState;

  UpdatePasswordState({required this.updatePasswordLoadState});

  factory UpdatePasswordState.initial() {
    return UpdatePasswordState(updatePasswordLoadState: LoadState.idle);
  }

  UpdatePasswordState copyWith({LoadState? updatePasswordLoadState}) {
    return UpdatePasswordState(
        updatePasswordLoadState:
            updatePasswordLoadState ?? this.updatePasswordLoadState);
  }
}
