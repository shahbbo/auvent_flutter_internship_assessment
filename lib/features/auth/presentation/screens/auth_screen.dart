import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/injections.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/routes/navigator_service.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/log_in_form.dart';
import '../widgets/sign_up_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: const AuthScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isAuthenticated) {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeScreen);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: appTheme.whiteCustom,
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20).r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: AppAssets.authBackground,
                      width: 300.w,
                      height: 300.h,
                    ),
                    _buildAnimatedForm(state),
                    SizedBox(height: 20.h),
                    if (state.errorMessage != null)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Text(
                          state.errorMessage!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    CustomTextButton(
                      text: state.formType == AuthFormType.login
                          ? 'Create an account'
                          : 'Already have an account',
                      onPressed: () {
                        context.read<AuthBloc>().add(ToggleAuthFormEvent(
                              state.formType == AuthFormType.signup,
                            ));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedForm(AuthState state) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: state.formType == AuthFormType.login
          ? const LogInForm(key: ValueKey('login'))
          : const SignUpForm(key: ValueKey('signup')),
    );
  }
}
