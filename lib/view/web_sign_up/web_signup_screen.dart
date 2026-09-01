import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class WebSignupScreen extends StatefulWidget {
  const WebSignupScreen({super.key});

  @override
  State<WebSignupScreen> createState() => _WebSignupScreenState();
}

class _WebSignupScreenState extends State<WebSignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(
        title: "Web Signup",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Header Section
                Text(
                  "Create Account",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: theme.colorScheme.primary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Join us to manage your payments easily and securely.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 40),

                // Email Field
                _buildLabel("Email Address", theme),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _emailController,
                  hintText: "example@mail.com",
                  icon: Icons.email_outlined,
                  theme: theme,
                  isDark: isDark,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),

                // Password Field
                _buildLabel("Password", theme),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _passwordController,
                  hintText: "Enter your password",
                  icon: Icons.lock_outline,
                  theme: theme,
                  isDark: isDark,
                  isPassword: true,
                  isPasswordVisible: _isPasswordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // Confirm Password Field
                _buildLabel("Confirm Password", theme),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _confirmPasswordController,
                  hintText: "Re-enter your password",
                  icon: Icons.lock_outline,
                  theme: theme,
                  isDark: isDark,
                  isPassword: true,
                  isPasswordVisible: _isConfirmPasswordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 40),

                // Submit Button
                CommonButton(
                  title: "Sign Up",
                  onTap: () {
                    Get.toNamed(AppRoutes.webotp);
                  },
                ),
                const SizedBox(height: 24),

                // Login Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, ThemeData theme) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required ThemeData theme,
    required bool isDark,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onVisibilityToggle,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      keyboardType: keyboardType,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 15,
        color: theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
          fontSize: 14,
        ),
        filled: true,
        fillColor: isDark ? theme.colorScheme.surfaceContainer : Colors.grey.shade50,
        prefixIcon: Icon(
          icon,
          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
          size: 22,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                  size: 22,
                ),
                onPressed: onVisibilityToggle,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? theme.colorScheme.outline.withValues(alpha: 0.3) : Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }
}
