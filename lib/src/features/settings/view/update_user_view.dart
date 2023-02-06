import 'package:brilloconnetz_test/src/core/constants/strings.dart';
import 'package:brilloconnetz_test/src/core/utils/enums.dart';
import 'package:brilloconnetz_test/src/core/utils/validation_extensions.dart';
import 'package:brilloconnetz_test/src/features/settings/view_model/update_profile.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_button.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_text_field.dart';
import 'package:brilloconnetz_test/src/general_widgets/spacing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdateProfileView extends StatefulWidget {
  final User user;

  const UpdateProfileView({Key? key, required this.user}) : super(key: key);

  @override
  UpdateProfileViewState createState() => UpdateProfileViewState();
}

class UpdateProfileViewState extends State<UpdateProfileView> {
  final _formKey = GlobalKey<FormState>();

  late final fullNameController = TextEditingController();

  @override
  void initState() {
    fullNameController.text = widget.user.displayName!;
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
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
                AppStrings.updateProfile,
                style: Theme.of(context).textTheme.headline6,
              ),
              const Spacing.smallHeight(),
              const Divider(color: Colors.black87),
              const Spacing.bigHeight(),
              Form(
                key: _formKey,
                child: AppTextField(
                  hintText: 'UserName',
                  label: 'UserName',
                  controller: fullNameController,
                  validateFunction: (value) =>
                      context.validateFieldNotEmpty(value, context),
                ),
              ),
              const Spacing.largeHeight(),
              Consumer(
                builder: (_, ref, __) => AppButton(
                  isLoading: ref
                          .watch(updateProfileNotifierProvider)
                          .updateProfileLoadState ==
                      LoadState.loading,
                  text: AppStrings.updateProfile,
                  onTap: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate()) {
                      await ref
                          .read(updateProfileNotifierProvider.notifier)
                          .updateProfile(fullNameController.text);
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
