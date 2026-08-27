import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../widgets/auth_hero_header.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  Timer? _timer;
  int _secondsLeft = 100;
  String? _error;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = 100);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _handleContinue() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length < 4) {
      setState(() => _error = AppStrings.otpErrorIncomplete);
      return;
    }
    setState(() => _error = null);
    context.push(AppRoutes.resetPassword);
  }

  String get _timerLabel {
    final minutes = _secondsLeft ~/ 60;
    final seconds = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthHeroHeader(title: AppStrings.otpTitle, subtitle: AppStrings.otpSubtitle),
            Padding(
              padding: responsive.padding(horizontal: 24).copyWith(top: responsive.spacing(45)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppStrings.otpLabel, style: AppTextStyles.fieldLabel),
                  SizedBox(height: responsive.spacing(8)),
                  Row(
                    children: List.generate(4, (index) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: index == 3 ? 0 : responsive.spacing(12)),
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: AppTextStyles.fieldLabel.copyWith(color: AppColors.border),
                            decoration: InputDecoration(
                              counterText: '',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(responsive.radius(12)),
                                borderSide: const BorderSide(color: AppColors.border, width: 0.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(responsive.radius(12)),
                                borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 3) {
                                _focusNodes[index + 1].requestFocus();
                              } else if (value.isEmpty && index > 0) {
                                _focusNodes[index - 1].requestFocus();
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                  if (_error != null) ...[
                    SizedBox(height: responsive.spacing(8)),
                    Text(_error!, style: AppTextStyles.bodySmall.copyWith(color: AppColors.error)),
                  ],
                  SizedBox(height: responsive.spacing(16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.otpDidntGetCode,
                        style: AppTextStyles.labelSmall.copyWith(color: const Color(0xFF2D3748), fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: responsive.spacing(16)),
                      GestureDetector(
                        onTap: _secondsLeft == 0 ? _startTimer : null,
                        child: Text(
                          '${AppStrings.otpResend} ($_timerLabel)',
                          style: AppTextStyles.labelSmall.copyWith(color: const Color(0xFF167EE6), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(28)),
                  AppButton(label: AppStrings.continueLabel, large: true, onPressed: _handleContinue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
