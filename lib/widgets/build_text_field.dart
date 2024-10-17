import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../utils/app_colors.dart';

class buildTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData prefixIcon;
  final TextInputType inputType;
  final bool obscureText;
  final bool isReadOnly;

  const buildTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
    required this.inputType,
    this.obscureText = false,
    this.isReadOnly = false, // Default is not read-only
  }) : super(key: key);

  @override
  _buildTextFieldState createState() => _buildTextFieldState();
}

class _buildTextFieldState extends State<buildTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText; // Initial obscureText value
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText: _obscureText,
      // Hide text if it's a password
      readOnly: widget.isReadOnly,
      // Make the field read-only if true
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.prefixIcon,
          color: AppColors.primaryColor,
        ),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.poppins(),
        filled: true,
        fillColor: Colors.white,
        counterText: '',
        // Hide character counter if maxLength is set
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.primaryColor,
          ),
        ),
        suffixIcon: widget.obscureText && !widget.isReadOnly
            ? IconButton(
                icon: Icon(
                  _obscureText ? IconlyLight.hide : IconlyLight.show,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      style: GoogleFonts.poppins(),
    );
  }
}
