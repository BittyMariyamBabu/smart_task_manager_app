import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task_manger/core/theme/app_spacings.dart';
import 'package:smart_task_manger/core/theme/pp_validators.dart';
import 'package:smart_task_manger/features/auth/presentation/widgets/auth_footer.dart';
import 'package:smart_task_manger/features/auth/presentation/widgets/auth_header.dart';
import 'package:smart_task_manger/features/auth/presentation/widgets/auth_layout.dart';
import 'package:smart_task_manger/widgets/app_button.dart';
import 'package:smart_task_manger/widgets/app_text_field.dart';

/// Displays the login form and handles user authentication.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  /// Disposes of the controllers when the widget is removed from the widget tree.
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Handles the login action when the user presses the login button.
  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // TODO: Call the login ViewModel.
    debugPrint('Login: $email / $password');
  }

  /// Navigates to the registration page.
  void _goToSignup() {
    // TODO: Navigate to RegisterPage.
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      formKey: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.xxl),

          const AuthHeader(
            title: 'Welcome back',
            subtitle: 'Sign in to continue managing your tasks.',
          ),

          AppTextField(
            controller: _emailController,
            label: 'Email',
            hintText: 'Enter your email',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AppValidators.validateEmail,
          ),

          const SizedBox(height: AppSpacing.md),

          AppTextField(
            controller: _passwordController,
            label: 'Password',
            maxLines: 1,
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscurePassword,
            validator: AppValidators.validateLoginPassword,
            onToggleObscured: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text('Forgot password?'),
            ),
          ),
      
          const SizedBox(height: AppSpacing.sm),

          AppButton(
            label: 'Login',
            onPressed: _login,
          ),

          const SizedBox(height: AppSpacing.xl),

          AuthFooter(
            mainText: "Don't have an account?",
            subText: 'Create account',
            onPressed: _goToSignup
          ),
        ],
      ),
    );
  }
}