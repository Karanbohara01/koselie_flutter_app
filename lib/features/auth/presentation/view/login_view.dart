// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:koselie/core/common/snackbar/snackbar.dart';
// import 'package:koselie/features/auth/presentation/view/register_view.dart';
// import 'package:koselie/features/auth/presentation/view/reset_password_view.dart';
// import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   _LoginViewState createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _forgotPasswordController = TextEditingController();
//   bool _isPasswordVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginBloc, LoginState>(
//       listener: (context, state) {
//         if (state.isOtpSent) {
//           showMySnackBar(
//             context: context,
//             message: "OTP sent successfully. Check your email/phone.",
//             color: Colors.green,
//           );
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ResetPasswordView(
//                   emailOrPhone: _forgotPasswordController.text),
//             ),
//           );
//         }
//         if (state.errorMessage.isNotEmpty) {
//           showMySnackBar(
//             context: context,
//             message: state.errorMessage,
//             color: Colors.red,
//           );
//         }
//       },
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         body: _buildLoginBody(),
//       ),
//     );
//   }

//   /// ✅ **Builds the main login screen**
//   Widget _buildLoginBody() {
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF8E2DE2), Color(0xFFEC008C)],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 10),
//               Image.asset('assets/logo/logo.png', height: 120, width: 130),
//               const SizedBox(height: 20),
//               Text(
//                 'Welcome back!',
//                 style: GoogleFonts.poppins(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         _buildTextField(
//                           controller: _usernameController,
//                           label: 'Username',
//                           icon: Icons.person,
//                         ),
//                         const SizedBox(height: 16),
//                         _buildTextField(
//                           controller: _passwordController,
//                           label: 'Password',
//                           icon: Icons.lock,
//                           isObscure: !_isPasswordVisible,
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _isPasswordVisible
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                               color: Colors.white70,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _isPasswordVisible = !_isPasswordVisible;
//                               });
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: TextButton(
//                             onPressed: () => _showForgotPasswordModal(),
//                             child: Text(
//                               "Forgot Password?",
//                               style: GoogleFonts.poppins(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 context.read<LoginBloc>().add(
//                                       LoginUserEvent(
//                                         context: context,
//                                         username: _usernameController.text,
//                                         password: _passwordController.text,
//                                       ),
//                                     );
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               foregroundColor: Colors.purple,
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child: Text(
//                               'Login',
//                               style: GoogleFonts.poppins(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         Center(
//                           child: GestureDetector(
//                             onTap: () {
//                               context.read<LoginBloc>().add(
//                                     NavigateRegisterScreenEvent(
//                                       destination: const RegisterView(),
//                                       context: context,
//                                     ),
//                                   );
//                             },
//                             child: Text(
//                               'Don\'t have an account? Register here',
//                               style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// ✅ **Forgot Password Modal (Improved & Longer)**
//   void _showForgotPasswordModal() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // ✅ Allows the modal to expand properly
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//             top: Radius.circular(20)), // ✅ Slightly larger border radius
//       ),
//       builder: (context) {
//         return FractionallySizedBox(
//           heightFactor:
//               0.6, // ✅ Increases modal height (60% of the screen height)
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 /// **🔹 Title**
//                 Text(
//                   "Forgot Password?",
//                   style: GoogleFonts.poppins(
//                     fontSize: 20, // ✅ Slightly larger font size
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10),

//                 /// **🔹 Instruction Text**
//                 Text(
//                   "Enter your email or phone number to receive an OTP for password reset.",
//                   style: GoogleFonts.poppins(
//                       fontSize: 14, color: Colors.grey[700]),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 20),

//                 /// **🔹 Input Field for Email or Phone**
//                 TextFormField(
//                   controller: _forgotPasswordController,
//                   keyboardType: TextInputType
//                       .emailAddress, // ✅ Supports both email & phone inputs
//                   decoration: InputDecoration(
//                     hintText: "Enter email or phone",
//                     prefixIcon: const Icon(Icons.email),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter an email or phone number.";
//                     }
//                     if (!RegExp(r"^(?:[+0-9]\d{9,14})|(?:\w+@\w+\.\w+)$")
//                         .hasMatch(value)) {
//                       return "Enter a valid email or phone number.";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 24),

//                 /// **🔹 Send OTP Button**
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_forgotPasswordController.text.isNotEmpty) {
//                       context.read<LoginBloc>().add(
//                             ForgotPasswordRequested(
//                               email: _forgotPasswordController.text,
//                               context: context,
//                             ),
//                           );
//                     } else {
//                       showMySnackBar(
//                         context: context,
//                         message: "Please enter email or phone number",
//                         color: Colors.red,
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.pink[700],
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 14, horizontal: 20),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     minimumSize: const Size(double.infinity, 50),
//                   ),
//                   child: context.watch<LoginBloc>().state.isLoading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text(
//                           "Send OTP",
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                 ),

//                 /// **🔹 Additional Spacing for Better UX**
//                 const SizedBox(height: 30),

//                 /// **🔹 Close Button**
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text(
//                     "Cancel",
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.pink),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   /// ✅ **Reusable TextField Widget**
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     bool isObscure = false,
//     Widget? suffixIcon,
//   }) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isObscure,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: Colors.white),
//         suffixIcon: suffixIcon,
//         filled: true,
//         fillColor: Colors.white.withOpacity(0.2),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//       ),
//       validator: (value) => value?.isEmpty ?? true ? 'Enter $label' : null,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koselie/core/common/snackbar/snackbar.dart';
import 'package:koselie/features/auth/presentation/view/register_view.dart';
import 'package:koselie/features/auth/presentation/view/reset_password_view.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _forgotPasswordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isOtpSent) {
          showMySnackBar(
            context: context,
            message: "OTP sent successfully. Check your email/phone.",
            color: Colors.green,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPasswordView(
                  emailOrPhone: _forgotPasswordController.text),
            ),
          );
        }
        if (state.errorMessage.isNotEmpty) {
          showMySnackBar(
            context: context,
            message: state.errorMessage,
            color: Colors.red,
          );
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: _buildLoginBody(),
      ),
    );
  }

  /// ✅ **Builds the main login screen**
  Widget _buildLoginBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8E2DE2),
            const Color(0xFFEC008C),
            Colors.deepPurple.shade400,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Hero(
                tag: 'app_logo',
                child: Image.asset('assets/logo/logo.png',
                    height: 120, width: 130),
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome back!',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: _usernameController,
                          label: 'Username',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          isObscure: !_isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => _showForgotPasswordModal(),
                            child: Text(
                              "Forgot Password?",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                      LoginUserEvent(
                                        context: context,
                                        username: _usernameController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.deepPurple,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 7,
                              shadowColor: Colors.deepPurple.withOpacity(0.5),
                            ),
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              context.read<LoginBloc>().add(
                                    NavigateRegisterScreenEvent(
                                      destination: const RegisterView(),
                                      context: context,
                                    ),
                                  );
                            },
                            child: Text(
                              'Don\'t have an account? Register here',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ **Forgot Password Modal (Improved & Longer)**
  void _showForgotPasswordModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// **🔹 Title**
                Text(
                  "Forgot Password?",
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const SizedBox(height: 12),

                /// **🔹 Instruction Text**
                Text(
                  "Enter your email or phone number to receive an OTP for password reset.",
                  style: GoogleFonts.poppins(
                      fontSize: 15, color: Colors.grey[700], height: 1.4),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                /// **🔹 Input Field for Email or Phone**
                TextFormField(
                  controller: _forgotPasswordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter email or phone",
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.black,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an email or phone number.";
                    }
                    if (!RegExp(r"^(?:[+0-9]\d{9,14})|(?:\w+@\w+\.\w+)$")
                        .hasMatch(value)) {
                      return "Enter a valid email or phone number.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                /// **🔹 Send OTP Button**
                ElevatedButton(
                  onPressed: () {
                    if (_forgotPasswordController.text.isNotEmpty) {
                      context.read<LoginBloc>().add(
                            ForgotPasswordRequested(
                              email: _forgotPasswordController.text,
                              context: context,
                            ),
                          );
                    } else {
                      showMySnackBar(
                        context: context,
                        message: "Please enter email or phone number",
                        color: Colors.red,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: const Size(double.infinity, 55),
                    elevation: 7,
                    shadowColor:
                        const Color.fromARGB(255, 16, 15, 15).withOpacity(0.5),
                  ),
                  child: context.watch<LoginBloc>().state.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Send OTP",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                ),

                /// **🔹 Additional Spacing for Better UX**
                const SizedBox(height: 36),

                /// **🔹 Close Button**
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.pink),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ✅ **Reusable TextField Widget**
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isObscure = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      validator: (value) => value?.isEmpty ?? true ? 'Enter $label' : null,
    );
  }
}
