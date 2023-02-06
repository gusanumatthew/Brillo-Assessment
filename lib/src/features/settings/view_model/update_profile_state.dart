import 'package:brilloconnetz_test/src/core/utils/enums.dart';

class UpdateProfileState {
  final LoadState updateProfileLoadState;

  UpdateProfileState({required this.updateProfileLoadState});

  factory UpdateProfileState.initial() {
    return UpdateProfileState(updateProfileLoadState: LoadState.idle);
  }

  UpdateProfileState copyWith({LoadState? updateProfileLoadState}) {
    return UpdateProfileState(
        updateProfileLoadState:
            updateProfileLoadState ?? this.updateProfileLoadState);
  }
}
