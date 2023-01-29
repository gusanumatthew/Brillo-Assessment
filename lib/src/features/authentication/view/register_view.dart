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

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;
    // final state = ref.watch(registerProvider);
    // final notifier = ref.read(registerProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
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
                  'Sign up',
                  style: textTheme.headline3,
                ),
                const Spacing.largeHeight(),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: () => setState(() {
                    _formKey.currentState!.validate();
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
                            context.validateEmailAddress(value, context),
                        controller: phone,
                      ),
                      const Spacing.bigHeight(),
                      AppTextField(
                        label: 'Password',
                        hintText: '*******',
                        // obscureText: state.obscureText,
                        validateFunction: (value) =>
                            context.validatePassword(value, context),
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
                          text: 'Sign up',
                          //isLoading: state.isLoading,
                          onTap: () async {
                            Navigator.pushNamed(context, Routes.dashboard);
                            FocusScope.of(context).unfocus();
                            // if (_formKey.currentState!.validate()) {
                            //   await notifier.registerUser(
                            //       email: email.text,
                            //       password: password.text,
                            //       displayName: name.text);
                            //}
                          }),
                      const Spacing.bigHeight(),
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
