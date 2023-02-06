import 'package:brilloconnetz_test/src/core/utils/enums.dart';

class UpdateEmailState {
  final LoadState updateEmailLoadState;

  UpdateEmailState({required this.updateEmailLoadState});

  factory UpdateEmailState.initial() {
    return UpdateEmailState(updateEmailLoadState: LoadState.idle);
  }

  UpdateEmailState copyWith({LoadState? updateEmailLoadState}) {
    return UpdateEmailState(
        updateEmailLoadState:
            updateEmailLoadState ?? this.updateEmailLoadState);
  }
}
