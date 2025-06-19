import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import 'custom_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  static Widget builder(BuildContext context) {
    return const SignUpForm();
  }

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController mailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    mailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).r,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                controller: mailController,
                hintText: 'mail',
                type: TextInputType.emailAddress,
                validator: Validators.validateEmail,
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                controller: passwordController,
                hintText: 'password',
                type: TextInputType.visiblePassword,
                validator: Validators.validatePassword,
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'confirm password',
                type: TextInputType.visiblePassword,
                validator: Validators.validatePassword,
              ),
              SizedBox(height: 10.h),
              CustomButton(
                  text: 'Sign Up',
                  onPressed: () {
                    if (formKey.currentState!.validate() &&
                        passwordController.text ==
                            confirmPasswordController.text) {
                      context.read<AuthBloc>().add(SignupEvent(
                            email: mailController.text.trim(),
                            password: passwordController.text,
                          ));
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
