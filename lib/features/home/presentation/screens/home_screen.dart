import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

/// Minimal landing screen after login; to be replaced by the fantasy
/// dashboard feature.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }
              return IconButton(
                tooltip: AppStrings.logout,
                icon: const Icon(Icons.logout_rounded),
                onPressed: () => context.read<AuthCubit>().logout(),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20.r),
          children: [
            Text(
              AppStrings.welcome,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 15.sp),
            ),
            Text(
              user.fullName,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.account_balance_wallet_rounded,
                    label: AppStrings.budget,
                    value: user.budget.toStringAsFixed(1),
                    suffix: AppStrings.currencySuffix,
                    color: AppColors.secondary,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _StatCard(
                    icon: Icons.emoji_events_rounded,
                    label: AppStrings.totalPoints,
                    value: '${user.totalPoints}',
                    suffix: AppStrings.pointsSuffix,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.suffix,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final String suffix;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 26.r),
          SizedBox(height: 12.h),
          Text(
            label,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
          ),
          SizedBox(height: 4.h),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextSpan(
                  text: ' $suffix',
                  style: TextStyle(fontSize: 12.sp, color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
