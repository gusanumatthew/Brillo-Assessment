import 'package:brilloconnetz_test/src/core/utils/enums.dart';

class SettingState {
  final LoadState settingsLoadState;

  SettingState({required this.settingsLoadState});

  factory SettingState.initial() {
    return SettingState(settingsLoadState: LoadState.idle);
  }

  SettingState copyWith({LoadState? settingsLoadState}) {
    return SettingState(
        settingsLoadState: settingsLoadState ?? this.settingsLoadState);
  }
}
