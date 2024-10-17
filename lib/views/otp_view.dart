import 'package:bite_bazaar/utils/config.dart';
import 'package:bite_bazaar/widgets/build_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:motion_toast/motion_toast.dart';

import '../controllers/auth_controller.dart';
import '../models/user_model.dart';
import '../utils/app_colors.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final String name;

  OtpScreen({super.key, required this.email, required this.name});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late TextEditingController emailController;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.email);
    nameController = TextEditingController(text: widget.name);
  }

  @override
  void dispose() {
    otpController.dispose();
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void signUpWithEmail(BuildContext context) {
    if (otpController.text.isEmpty || passwordController.text.isEmpty) {
      MotionToast.error(
        toastDuration: const Duration(seconds: 5),
        description: Text(
          'All fields are required!',
          style: GoogleFonts.poppins(),
        ),
      ).show(context);
    } else {
      authController.signUpWithEmail(
        UserModel(
          name: widget.name,
          email: widget.email,
          password: passwordController.text.trim(),
        ),
        otpController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppConfig.otpSvg,
                  height: size.height * .4,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'OTP Verification',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      letterSpacing: .5,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Enter the OTP sent to your email to verify your identity.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      letterSpacing: .5,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                buildTextField(
                  hintText: 'Name',
                  controller: nameController,
                  prefixIcon: IconlyLight.profile,
                  inputType: TextInputType.name,
                  isReadOnly: true,
                ),
                const SizedBox(height: 20),
                buildTextField(
                  hintText: 'Email',
                  controller: emailController,
                  prefixIcon: IconlyLight.message,
                  inputType: TextInputType.emailAddress,
                  isReadOnly: true,
                ),
                const SizedBox(height: 20),
                buildTextField(
                  hintText: 'Password',
                  controller: passwordController,
                  prefixIcon: IconlyLight.lock,
                  inputType: TextInputType.text,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                buildTextField(
                  hintText: 'OTP',
                  controller: otpController,
                  prefixIcon: IconlyLight.password,
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width * .9,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    onPressed: () => signUpWithEmail(context),
                    child: authController.isLoading.value
                        ? Text(
                            'Signing up...',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              letterSpacing: .5,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : Text(
                            'Sign Up',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              letterSpacing: .5,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
