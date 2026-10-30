import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/app_colors.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../cubit/auth_cubit.dart';
import '../screens/login_screen.dart';
import 'pitch_background.dart';

/// Root route: swaps between splash, login and home based on session state.
///
/// Loading/error states are ignored here so the login form stays on screen
/// while a request is in flight or after a failed attempt.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (_, current) =>
          current is Authenticated || current is Unauthenticated,
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          child: switch (state) {
            Authenticated(:final user) => HomeScreen(
              key: const ValueKey('home'),
              user: user,
            ),
            Unauthenticated() => const LoginScreen(key: ValueKey('login')),
            _ => const _SplashView(key: ValueKey('splash')),
          },
        );
      },
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PitchBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.sports_soccer_rounded,
                size: 72.r,
                color: AppColors.primary,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: 28.r,
                height: 28.r,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
