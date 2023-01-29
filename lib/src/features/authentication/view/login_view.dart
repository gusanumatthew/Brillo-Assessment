import 'package:brilloconnetz_test/src/core/constants/strings.dart';
import 'package:brilloconnetz_test/src/core/routes.dart';
import 'package:brilloconnetz_test/src/core/utils/validation_extensions.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_button.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_text_field.dart';
import 'package:brilloconnetz_test/src/general_widgets/spacing.dart';
import 'package:brilloconnetz_test/src/general_widgets/two_colored_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;
    // final state = ref.watch(loginProvider);
    // final notifier = ref.read(loginProvider.notifier);
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
                        // obscureText: state.obscureText,
                        validateFunction: (value) =>
                            context.validateFieldNotEmpty(value, context),
                        controller: password,
                        // suffixIcon: IconButton(
                        //   color: AppColors.deep,
                        //   icon: Icon(
                        //     state.obscureText
                        //         ? Icons.visibility_off_outlined
                        //         : Icons.visibility_outlined,
                        //   ),
                        //   onPressed: () => notifier.passwordVisibility(),
                        // ),
                      ),
                      const Spacing.largeHeight(),
                      AppButton(
                        text: 'Sign in',
                        onTap: () {
                          // FocusScope.of(context).unfocus();
                          // if (_formKey.currentState!.validate()) {
                          //   notifier.loginUser(
                          //       email: email.text, password: password.text);
                          Navigator.pushNamed(context, Routes.dashboard);
                          // }
                        },
                      ),
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
