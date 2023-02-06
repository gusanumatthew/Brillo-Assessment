import 'package:brilloconnetz_test/src/core/constants/strings.dart';
import 'package:brilloconnetz_test/src/core/utils/enums.dart';
import 'package:brilloconnetz_test/src/core/utils/validation_extensions.dart';
import 'package:brilloconnetz_test/src/features/settings/view_model/update_password_notifier.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_button.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_text_field.dart';
import 'package:brilloconnetz_test/src/general_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({super.key});

  @override
  UpdatePasswordViewState createState() => UpdatePasswordViewState();
}

class UpdatePasswordViewState extends State<UpdatePasswordView> {
  final _formKey = GlobalKey<FormState>();

  late final oldPasswordController = TextEditingController();
  late final newPasswordController = TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
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
                AppStrings.updatePassword,
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
                      hintText: AppStrings.oldPassword,
                      keyboardType: TextInputType.visiblePassword,
                      controller: oldPasswordController,
                      validateFunction: (value) =>
                          context.validatePassword(value, context),
                    ),
                    const Spacing.bigHeight(),
                    AppTextField(
                      hintText: AppStrings.newPassword,
                      controller: newPasswordController,
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
                          .watch(updatePasswordNotifierProvider)
                          .updatePasswordLoadState ==
                      LoadState.loading,
                  text: AppStrings.updatePassword,
                  onTap: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate()) {
                      await ref
                          .read(updatePasswordNotifierProvider.notifier)
                          .updatePassword(
                            oldPasswordController.text,
                            newPasswordController.text,
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
