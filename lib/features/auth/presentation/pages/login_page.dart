import 'package:flutter/material.dart';
import 'package:smart_task_manger/core/theme/app_spacings.dart';
import 'package:smart_task_manger/features/auth/presentation/widgets/auth_brand.dart';
import 'package:smart_task_manger/features/auth/presentation/widgets/auth_footer.dart';
import 'package:smart_task_manger/features/auth/presentation/widgets/auth_header.dart';
import 'package:smart_task_manger/features/auth/presentation/widgets/auth_layout.dart';
import 'package:smart_task_manger/features/auth/presentation/widgets/login_form.dart';

/// Displays the login form and handles user authentication.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.xxl),

          const AuthBrand(),

          const SizedBox(height: AppSpacing.xxl),

          const AuthHeader(
            title: 'Welcome back',
            subtitle: 'Sign in to continue managing your tasks.',
          ),

          const LoginForm(),

          const SizedBox(height: AppSpacing.xl),

          AuthFooter(
            mainText: "Don't have an account?",
            subText: 'Create account',
            onPressed: () {
              // Navigate to RegisterPage
            },
          ),
        ],
      ),
    );
  }
}