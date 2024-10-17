import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';
import '../views/otp_view.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  // Send OTP to email
  Future<void> sendOtpToEmail(String email, String name) async {
    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse('https://bite-bazaar-server-private.onrender.com/api/users/send-email-otp'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'name': name,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Get.snackbar('Success', 'OTP sent to email');
        Get.to(() => OtpScreen(email: email, name: name));
      } else {
        var error = jsonDecode(response.body);
        Get.snackbar('Error', error['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to send OTP');
    } finally {
      isLoading(false);
    }
  }

  // Sign-Up Method
  Future<void> signUpWithEmail(UserModel user, String otp) async {
    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse('https://bite-bazaar-server-private.onrender.com/api/users/signup-with-email'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': user.email,
          'name': user.name,
          'password': user.password,
          'otp': otp,
        }),
      );

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        Get.snackbar('Success', data['message']);
        // Optionally, navigate to sign-in page after successful sign-up
      } else {
        var error = jsonDecode(response.body);
        Get.snackbar('Error', error['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Sign-Up Failed');
    } finally {
      isLoading(false);
    }
  }

  // Sign-In Method
  Future<void> signInWithEmail(String email, String password) async {
    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse('https://bite-bazaar-server-private.onrender.com/api/users/signin-with-email'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Get.snackbar('Success', 'Signed in successfully');
      } else {
        var error = jsonDecode(response.body);
        Get.snackbar('Error', error['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Sign-In Failed');
    } finally {
      isLoading(false);
    }
  }
}
