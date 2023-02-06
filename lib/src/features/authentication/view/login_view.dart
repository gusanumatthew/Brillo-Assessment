import 'package:brilloconnetz_test/src/core/constants/colors.dart';
import 'package:brilloconnetz_test/src/core/constants/strings.dart';
import 'package:brilloconnetz_test/src/core/routes.dart';
import 'package:brilloconnetz_test/src/core/utils/enums.dart';
import 'package:brilloconnetz_test/src/core/utils/validation_extensions.dart';
import 'package:brilloconnetz_test/src/features/authentication/view_model/login_notifier.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_button.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_text_field.dart';
import 'package:brilloconnetz_test/src/general_widgets/spacing.dart';
import 'package:brilloconnetz_test/src/general_widgets/two_colored_text.dart';
import 'package:brilloconnetz_test/src/services/navigation_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacing.height(height * 0.15),
                const Hero(
                  tag: "Brillo",
                  child: TwoColoredText(
                    first: 'Brillo',
                    second: 'Connectz',
                    fontSize: 28,
                  ),
                ),
                const Spacing.largeHeight(),
                const Spacing.largeHeight(),
                Text(
                  'Sign in',
                  style: textTheme.headline3,
                ),
                const Spacing.largeHeight(),
                Form(
                  onChanged: () => setState(() {
                    _formKey.currentState!.validate();
                  }),
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      AppTextField(
                        label: AppStrings.emailPhone,
                        hintText: 'doe@gmail.com / 09064081032',
                        keyboardType: TextInputType.emailAddress,
                        validateFunction: (value) =>
                            context.validateFieldNotEmpty(value, context),
                        controller: email,
                      ),
                      const Spacing.bigHeight(),
                      AppTextField(
                        label: AppStrings.password,
                        hintText: '*******',
                        keyboardType: TextInputType.visiblePassword,
                        validateFunction: (value) =>
                            context.validateFieldNotEmpty(value, context),
                        controller: password,
                      ),
                      const Spacing.bigHeight(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Consumer(builder: (context, ref, __) {
                          return InkWell(
                            onTap: () {
                              ref
                                  .read(navigationService)
                                  .navigateToNamed(Routes.forgot);
                            },
                            child: Text(
                              'Forgot Password ?',
                              style: textTheme.headline4?.copyWith(
                                color: AppColors.lightBlue,
                              ),
                            ),
                          );
                        }),
                      ),
                      const Spacing.largeHeight(),
                      Consumer(builder: (context, ref, child) {
                        final state = ref.watch(loginProvider);
                        final notifier = ref.read(loginProvider.notifier);
                        return AppButton(
                          isLoading: state.loginLoadState == LoadState.loading,
                          text: 'Sign in',
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              notifier.loginUser(
                                  email: email.text, password: password.text);
                            }
                          },
                        );
                      }),
                      const Spacing.bigHeight(),
                      Text.rich(
                        TextSpan(
                          text: AppStrings.dont,
                          style: TextStyle(color: colorScheme.onBackground),
                          children: [
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(color: colorScheme.primary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.register);
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
