import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/presentation/widgets/app_bar.dart';
import '../../../../core/presentation/widgets/button.dart';
import '../../../../core/presentation/widgets/router.dart';
import '../../../../core/presentation/widgets/text_holder.dart';
import '../../../../core/utils/data/color_utils.dart';
import '../login_flow/login_screen.dart';
import 'set_password_screen.dart';

class VerifyPasswordEmailScreen extends StatefulWidget {
  final String email;

  const VerifyPasswordEmailScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyPasswordEmailScreen> createState() => _VerifyPasswordEmailScreenState();
}

class _VerifyPasswordEmailScreenState extends State<VerifyPasswordEmailScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  int _resendTimer = 60;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _canResend = false;
    _resendTimer = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  void _resendCode() {
    if (_canResend) {
      // TODO: Implement resend verification code logic for password reset
      _startTimer();
    }
  }

  String _maskEmail(String email) {
    if (email.length <= 2) return email;
    final lastTwo = email.substring(email.length - 2);
    return '${'*' * (email.length - 2)}$lastTwo';
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Forgot password',
        showBackIcon: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(40),
                        Image.asset(
                          "assets/images/brown_check.png",
                          width: 80,
                          height: 80,
                        ),
                        Gap(32),
                        TextHolder(
                          title: 'Enter the 6-digit code we texted to your linked\nemail address ${_maskEmail(widget.email)}',
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          align: TextAlign.start,
                        ),
                        Gap(8),
                        TextHolder(
                          title: 'This helps keep your account safe by verifying it\'s you',
                          size: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey.shade600,
                          align: TextAlign.left,
                        ),
                        Gap(40),
                        PinCodeTextField(
                          appContext: context,
                          length: 6,
                          controller: _otpController,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            fieldHeight: 56,
                            fieldWidth: 48,
                            activeFillColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            selectedFillColor: Colors.white,
                            activeColor: "#C5A35E".toColor(),
                            inactiveColor: Colors.grey.shade300,
                            selectedColor: "#C5A35E".toColor(),
                            borderWidth: 1.5,
                          ),
                          enableActiveFill: true,
                          onCompleted: (value) {
                            // Auto-submit when 6 digits are entered
                            _verifyCode(value);
                          },
                          onChanged: (value) {},
                        ),
                        Gap(24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextHolder(
                              title: 'Didn\'t receive OTP? ',
                              size: 14,
                              color: Colors.grey.shade600,
                            ),
                            GestureDetector(
                              onTap: _canResend ? _resendCode : null,
                              child: TextHolder(
                                title: _canResend 
                                    ? 'Resend Code' 
                                    : 'Resend Code(${_resendTimer}s)',
                                size: 14,
                                color: _canResend 
                                    ? "#C5A35E".toColor() 
                                    : Colors.grey.shade400,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 30),
                  child: Column(
                    children: [
                      CustomButtom(
                        title: 'Proceed',
                        btnColor: "#C5A35E".toColor(),
                        textColor: Colors.white,
                        onTap: () {
                          if (_otpController.text.length == 6) {
                            _verifyCode(_otpController.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: TextHolder(
                                  title: 'Please enter the 6-digit code',
                                  color: Colors.white,
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                      Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextHolder(
                            title: 'Didn\'t forget password? ',
                            color: Colors.grey.shade600,
                            size: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              router.push(const LoginScreen());
                            },
                            child: TextHolder(
                              title: 'Sign In',
                              color: "#C5A35E".toColor(),
                              fontWeight: FontWeight.bold,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _verifyCode(String code) {
    // TODO: Implement password reset code verification logic
    // Navigate to set password screen after successful verification
    router.push(const SetPasswordScreen());
  }
}
