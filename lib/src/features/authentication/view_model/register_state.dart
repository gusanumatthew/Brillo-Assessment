import 'package:brilloconnetz_test/src/core/utils/enums.dart';

class RegisterState {
  final LoadState registerLoadState;
  List<int> pressColor;
  List<int> selectedInterest;

  RegisterState(
      {required this.registerLoadState,
      required this.pressColor,
      required this.selectedInterest});

  factory RegisterState.initial() {
    return RegisterState(
        registerLoadState: LoadState.idle,
        pressColor: [],
        selectedInterest: []);
  }

  RegisterState copyWith({
    LoadState? registerLoadState,
    List<int>? pressColor,
    List<int>? selectedInterest,
  }) {
    return RegisterState(
      registerLoadState: registerLoadState ?? this.registerLoadState,
      selectedInterest: selectedInterest ?? this.selectedInterest,
      pressColor: pressColor ?? this.pressColor,
    );
  }
}
