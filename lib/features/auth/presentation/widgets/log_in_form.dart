import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import 'custom_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  static Widget builder(BuildContext context) {
    return const LogInForm();
  }

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController mailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    mailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void submitForm() {
    final email = mailController.text.trim();
    final password = passwordController.text;
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(LoginEvent(
            email: email,
            password: password,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ).r,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Log In',
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
              CustomButton(
                  text: 'Log In',
                  onPressed: () {
                    submitForm();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
