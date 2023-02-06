import 'package:brilloconnetz_test/src/core/constants/strings.dart';
import 'package:brilloconnetz_test/src/core/utils/enums.dart';
import 'package:brilloconnetz_test/src/core/utils/validation_extensions.dart';
import 'package:brilloconnetz_test/src/features/settings/view_model/update_email_notifier.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_button.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_text_field.dart';
import 'package:brilloconnetz_test/src/general_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdateEmailView extends StatefulWidget {
  const UpdateEmailView({super.key});

  @override
  UpdateEmailViewState createState() => UpdateEmailViewState();
}

class UpdateEmailViewState extends State<UpdateEmailView> {
  final _formKey = GlobalKey<FormState>();

  late final emailAddressController = TextEditingController();
  late final passwordController = TextEditingController();

  @override
  void dispose() {
    emailAddressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding:
              const EdgeInsets.all(24.0) + MediaQuery.of(context).viewInsets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacing.smallHeight(),
              Text(
                AppStrings.updateEmail,
                style: Theme.of(context).textTheme.headline6,
              ),
              const Spacing.smallHeight(),
              const Divider(color: Colors.black87),
              const Spacing.bigHeight(),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextField(
                      hintText: AppStrings.email,
                      controller: emailAddressController,
                      keyboardType: TextInputType.emailAddress,
                      validateFunction: (value) =>
                          context.validateEmailAddress(value, context),
                    ),
                    const Spacing.bigHeight(),
                    AppTextField(
                      hintText: AppStrings.password,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validateFunction: (value) =>
                          context.validatePassword(value, context),
                    ),
                  ],
                ),
              ),
              const Spacing.largeHeight(),
              Consumer(
                builder: (_, ref, __) => AppButton(
                  isLoading: ref
                          .watch(updateEmailNotifierProvider)
                          .updateEmailLoadState ==
                      LoadState.loading,
                  text: AppStrings.updateEmail,
                  onTap: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate()) {
                      await ref
                          .read(updateEmailNotifierProvider.notifier)
                          .updateEmail(
                            emailAddressController.text.trim(),
                            passwordController.text,
                          );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
