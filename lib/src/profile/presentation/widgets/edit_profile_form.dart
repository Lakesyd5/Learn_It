import 'package:flutter/material.dart';
import 'package:learn_it/core/extensions/context_extensions.dart';
import 'package:learn_it/core/extensions/string_extension.dart';
import 'package:learn_it/src/profile/presentation/widgets/edit_profile_form_field.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.bioController,
    required this.oldPasswordController,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController bioController;
  final TextEditingController oldPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProfileFormField(
          fieldTitle: 'FULL NAME',
          controller: fullNameController,
          hintText: context.currentUser!.fullName,
        ),
        EditProfileFormField(
          fieldTitle: 'EMAIL',
          controller: emailController,
          hintText: context.currentUser!.email.obscureEmail,
        ),
        EditProfileFormField(
          fieldTitle: 'CURRENT PASSWORD',
          controller: oldPasswordController,
          hintText: '********',
        ),
        StatefulBuilder(
          builder: (context, setState) {
            oldPasswordController.addListener(() => setState(() {}));
            return EditProfileFormField(
              fieldTitle: 'NEW PASSWORD',
              controller: passwordController,
              hintText: '********',
              readOnly: oldPasswordController.text.isEmpty,
            );
          },
        ),
        EditProfileFormField(
          fieldTitle: 'BIO',
          controller: bioController,
          hintText: context.currentUser!.bio,
        ),
      ],
    );
  }
}
