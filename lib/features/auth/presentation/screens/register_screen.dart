import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/pitch_background.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().register(
      fullName: _fullNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: PitchBackground(
        child: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is Authenticated) {
                // AuthGate (the root route) now shows Home.
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            builder: (context, state) {
              final isLoading = state is AuthLoading;
              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: AutofillGroup(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const AuthHeader(
                            title: AppStrings.registerTitle,
                            subtitle: AppStrings.registerSubtitle,
                          ),
                          SizedBox(height: 32.h),
                          AuthTextField(
                            controller: _fullNameController,
                            label: AppStrings.fullNameLabel,
                            hint: AppStrings.fullNameHint,
                            icon: Icons.person_outline_rounded,
                            keyboardType: TextInputType.name,
                            autofillHints: const [AutofillHints.name],
                            validator: Validators.fullName,
                            enabled: !isLoading,
                          ),
                          SizedBox(height: 18.h),
                          AuthTextField(
                            controller: _emailController,
                            label: AppStrings.emailLabel,
                            hint: AppStrings.emailHint,
                            icon: Icons.alternate_email_rounded,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            validator: Validators.email,
                            enabled: !isLoading,
                          ),
                          SizedBox(height: 18.h),
                          AuthTextField(
                            controller: _passwordController,
                            label: AppStrings.passwordLabel,
                            hint: AppStrings.passwordHint,
                            icon: Icons.lock_outline_rounded,
                            isPassword: true,
                            autofillHints: const [AutofillHints.newPassword],
                            validator: Validators.password,
                            enabled: !isLoading,
                          ),
                          SizedBox(height: 18.h),
                          AuthTextField(
                            controller: _confirmPasswordController,
                            label: AppStrings.confirmPasswordLabel,
                            hint: AppStrings.confirmPasswordHint,
                            icon: Icons.lock_reset_rounded,
                            isPassword: true,
                            textInputAction: TextInputAction.done,
                            validator: (value) => Validators.confirmPassword(
                              value,
                              _passwordController.text,
                            ),
                            enabled: !isLoading,
                            onFieldSubmitted: (_) => _submit(),
                          ),
                          SizedBox(height: 32.h),
                          AuthButton(
                            label: AppStrings.registerButton,
                            isLoading: isLoading,
                            onPressed: _submit,
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.haveAccount,
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14.sp,
                                ),
                              ),
                              TextButton(
                                onPressed: isLoading
                                    ? null
                                    : () => Navigator.of(context).pop(),
                                child: const Text(AppStrings.goToLogin),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
