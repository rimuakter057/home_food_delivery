import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';
import '../state/splash_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(SplashConfig.displayDuration, () {
      if (!mounted) return;
      context.go(AppRoutes.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          return Stack(
            children: [
              _blob(left: 0.4732 * w, top: -0.055 * h, size: 0.6534 * w),
              _blob(left: -0.2243 * w, top: 0.2587 * h, size: 1.0241 * w),
              _blob(left: 0.1935 * w, top: 0.7431 * h, size: 0.7212 * w),
              Center(
                child: Image.asset(AppAssets.brandLogo, width: w * 0.746),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _blob({required double left, required double top, required double size}) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.07), shape: BoxShape.circle),
      ),
    );
  }
}
