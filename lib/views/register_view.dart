import 'package:bite_bazaar/utils/config.dart';
import 'package:bite_bazaar/widgets/build_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:motion_toast/motion_toast.dart';

import '../controllers/auth_controller.dart';
import '../utils/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final AuthController authController = Get.put(AuthController());

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void sendOtp() {
    if (nameController.text.isEmpty || emailController.text.isEmpty) {
      MotionToast.error(
        toastDuration: const Duration(seconds: 5),
        description: Text(
          'All fields are required!',
          style: GoogleFonts.poppins(),
        ),
      ).show(context);
    } else {
      authController.sendOtpToEmail(
        emailController.text.trim(),
        nameController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppConfig.registerSvg,
                  height: size.height * .4,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Register',
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
                    'Enter your personal information',
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
                    inputType: TextInputType.name),
                const SizedBox(height: 20),
                buildTextField(
                    hintText: 'Email',
                    controller: emailController,
                    prefixIcon: IconlyLight.message,
                    inputType: TextInputType.emailAddress),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width * .9,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    onPressed: sendOtp,
                    child: authController.isLoading.value
                        ? Text(
                            'Registering...',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              letterSpacing: .5,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : Text(
                            'Register',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              letterSpacing: .5,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.w600,
                          letterSpacing: .5),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              letterSpacing: .5),
                        ))
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
