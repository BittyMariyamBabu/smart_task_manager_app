import 'package:flutter/material.dart';
import 'package:smart_task_manger/core/theme/app_spacings.dart';
import 'package:smart_task_manger/features/auth/presentation/pages/login_page.dart';
import 'package:smart_task_manger/features/auth/presentation/widgets/auth_brand.dart';
import 'package:smart_task_manger/features/auth/presentation/widgets/auth_footer.dart';
import 'package:smart_task_manger/features/auth/presentation/widgets/auth_header.dart';
import 'package:smart_task_manger/features/auth/presentation/widgets/auth_layout.dart';
import 'package:smart_task_manger/features/auth/presentation/widgets/signup_form.dart';

/// Displays the sign up form and handles user authentication.
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.md),

          const AuthBrand(),

          const SizedBox(height: AppSpacing.md),

          const AuthHeader(
            title: 'Create an account',
            subtitle: 'Sign up to get started with the Smart Task Manager.',
          ),

          const SignUpForm(),

          const SizedBox(height: AppSpacing.xl),

          AuthFooter(
            mainText: "Don't have an account?",
            subText: 'Create account',
            onPressed: () => () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}