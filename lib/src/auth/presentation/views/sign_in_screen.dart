import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_it/core/common/app/providers/user_provider.dart';
import 'package:learn_it/core/common/widgets/gradient_background.dart';
import 'package:learn_it/core/common/widgets/rounded_button.dart';
import 'package:learn_it/core/res/fonts.dart';
import 'package:learn_it/core/res/media_res.dart';
import 'package:learn_it/core/utils/core_utils.dart';
import 'package:learn_it/src/auth/data/model/user_model.dart';
import 'package:learn_it/src/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:learn_it/src/auth/presentation/views/sign_up_screen.dart';
import 'package:learn_it/src/auth/presentation/widgets/sign_in_form.dart';
import 'package:learn_it/src/dashboard/presentation/views/dashboard.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(state.user as LocalUserModel);
            Navigator.pushNamed(context, Dashboard.routeName);
          }
        },
        builder: (context, state) {
          return GradientBackground(
            image: MediaRes.authGradientBackground,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const Text(
                    'Easy to learn, discover more skills.',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      fontFamily: Fonts.aeonik,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sign in to your account',
                        style: TextStyle(fontSize: 14),
                      ),
                      Baseline(
                        baseline: 100,
                        baselineType: TextBaseline.alphabetic,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              SignUpScreen.routeName,
                            );
                          },
                          child: const Text('Register account?'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SignInForm(
                    emailController: emailController,
                    passwordController: passwordController,
                    formKey: formKey,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/forgot-password');
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (state is AuthLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    ListenableBuilder(
                      listenable: Listenable.merge([emailController, passwordController]),
                      builder: (BuildContext context, Widget? child) {
                        final enable = emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
                        return RoundedButton(
                          label: 'Sign In',
                          onPressed: enable ? () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            FirebaseAuth.instance.currentUser?.reload();
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    SignInEvent(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                            }
                          } : null,
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
