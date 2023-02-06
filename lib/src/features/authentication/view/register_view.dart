import 'package:brilloconnetz_test/src/core/constants/colors.dart';
import 'package:brilloconnetz_test/src/core/constants/strings.dart';
import 'package:brilloconnetz_test/src/core/routes.dart';
import 'package:brilloconnetz_test/src/core/utils/enums.dart';
import 'package:brilloconnetz_test/src/core/utils/validation_extensions.dart';
import 'package:brilloconnetz_test/src/features/authentication/model/interest_model.dart';
import 'package:brilloconnetz_test/src/features/authentication/model/register_params.dart';
import 'package:brilloconnetz_test/src/features/authentication/view_model/register_notifier.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_button.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_text_field.dart';
import 'package:brilloconnetz_test/src/general_widgets/interest_tile.dart';
import 'package:brilloconnetz_test/src/general_widgets/spacing.dart';
import 'package:brilloconnetz_test/src/general_widgets/two_colored_text.dart';
import 'package:brilloconnetz_test/src/services/snackbar_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends ConsumerState<RegisterView> {
  late Box<Interest> interestBox;
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    interestBox = Hive.box<Interest>('interestBox');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;
    final state = ref.watch(registerProvider);
    final notifier = ref.read(registerProvider.notifier);
    final snack = ref.read(snackbarService);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Spacing.height(height * 0.01),
                const Hero(
                  tag: "Brillo",
                  child: TwoColoredText(
                    first: 'Brillo',
                    second: 'Connectz',
                    fontSize: 28,
                  ),
                ),
                const Spacing.bigHeight(),
                Text(
                  'Sign up',
                  style: textTheme.headline3,
                ),
                const Spacing.bigHeight(),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: () => setState(() {
                    isEnabled = _formKey.currentState!.validate();
                  }),
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppTextField(
                        label: 'Username',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        hintText: 'DeveloperMatt',
                        validateFunction: (value) =>
                            context.validateFieldNotEmpty(value, context),
                        controller: name,
                      ),
                      const Spacing.bigHeight(),
                      AppTextField(
                        label: AppStrings.email,
                        hintText: '@example.com',
                        keyboardType: TextInputType.emailAddress,
                        validateFunction: (value) =>
                            context.validateEmailAddress(value, context),
                        controller: email,
                      ),
                      const Spacing.bigHeight(),
                      AppTextField(
                        label: AppStrings.phone,
                        hintText: '09064081032',
                        keyboardType: TextInputType.phone,
                        validateFunction: (value) =>
                            context.validatePhone(value, context),
                        controller: phone,
                      ),
                      const Spacing.bigHeight(),
                      Text(
                        'Interests',
                        style: textTheme.headline4?.copyWith(
                          color: AppColors.dark,
                        ),
                      ),
                      const Spacing.smallHeight(),
                      SizedBox(
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: interests
                              .map(
                                (model) => GestureDetector(
                                  onTap: () {
                                    notifier.updateSelectedInterest(model.id);
                                    interestBox.put(model.id, model);
                                  },
                                  child: InterestTile(
                                    model: model,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const Spacing.bigHeight(),
                      AppTextField(
                        label: 'Password',
                        hintText: '*******',
                        validateFunction: (value) =>
                            context.validatePassword(value, context),
                        controller: password,
                      ),
                      const Spacing.bigHeight(),
                      AppButton(
                          text: 'Sign up',
                          isEnabled: isEnabled,
                          isLoading:
                              state.registerLoadState == LoadState.loading,
                          onTap: () {
                            state.selectedInterest.isEmpty
                                ? snack.showErrorSnackBar(
                                    'Select at least 1 interest and continue 😉',
                                  )
                                : notifier.registerUser(
                                    params: RegisterParams(
                                      email: email.text,
                                      password: password.text,
                                      phone: phone.text,
                                      userName: name.text,
                                    ),
                                  );
                          }),
                      const Spacing.mediumHeight(),
                      Text.rich(
                        TextSpan(
                          text: AppStrings.alreadyAccount,
                          style: TextStyle(color: colorScheme.onBackground),
                          children: [
                            TextSpan(
                              text: 'Sign in',
                              style: TextStyle(color: colorScheme.primary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.login);
                                },
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
