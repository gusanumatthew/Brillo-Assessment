import 'package:brilloconnetz_test/src/core/constants/strings.dart';
import 'package:brilloconnetz_test/src/core/utils/enums.dart';
import 'package:brilloconnetz_test/src/core/utils/validation_extensions.dart';
import 'package:brilloconnetz_test/src/features/authentication/view_model/forget_password_notifier.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_button.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_text_field.dart';
import 'package:brilloconnetz_test/src/general_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();

  late final emailAddressController = TextEditingController();

  @override
  void dispose() {
    emailAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordState = ref.watch(forgotPasswordNotifierProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.all(24.0) + MediaQuery.of(context).viewInsets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacing.smallHeight(),
              Text(
                'Forgot Password',
                style: Theme.of(context).textTheme.headline6,
              ),
              const Spacing.smallHeight(),
              const Divider(color: Colors.black87),
              const Spacing.smallHeight(),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(AppStrings.forgotPasswordText),
                    const Spacing.largeHeight(),
                    AppTextField(
                      hintText: AppStrings.email,
                      controller: emailAddressController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      validateFunction: (value) =>
                          context.validateEmailAddress(value, context),
                    ),
                  ],
                ),
              ),
              const Spacing.largeHeight(),
              Consumer(
                builder: (_, ref, __) => AppButton(
                  isLoading:
                      forgotPasswordState.forgetLoadState == LoadState.loading,
                  text: AppStrings.resetPassword,
                  onTap: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate()) {
                      await ref
                          .read(forgotPasswordNotifierProvider.notifier)
                          .resetPassword(emailAddressController.text.trim());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
