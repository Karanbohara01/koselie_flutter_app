// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart'; // For social login buttons
// import 'package:google_fonts/google_fonts.dart';
// import 'package:koselie/features/auth/presentation/view/register_view.dart';
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
//   bool _isPasswordVisible = false; // Track password visibility

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true, // ✅ Make full screen
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity, // ✅ Full screen coverage
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF8E2DE2), // Dark Purple
//               Color(0xFFEC008C), // Pinkish Gradient
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 10),

//                 // ✅ Logo
//                 Image.asset(
//                   'assets/logo/logo.png',
//                   height: 120,
//                   width: 130,
//                 ),
//                 const SizedBox(height: 20),

//                 // ✅ Welcome Text
//                 Text(
//                   'Welcome back!',
//                   style: GoogleFonts.poppins(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 // ✅ Form Fields
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           // ✅ Username Field
//                           _buildTextField(
//                             controller: _usernameController,
//                             label: 'Username',
//                             icon: Icons.person,
//                           ),

//                           const SizedBox(height: 16),

//                           // ✅ Password Field
//                           _buildTextField(
//                             controller: _passwordController,
//                             label: 'Password',
//                             icon: Icons.lock,
//                             isObscure: !_isPasswordVisible,
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _isPasswordVisible
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                                 color: Colors.white70,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _isPasswordVisible = !_isPasswordVisible;
//                                 });
//                               },
//                             ),
//                           ),

//                           const SizedBox(height: 24),

//                           // ✅ Login Button
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 if (_formKey.currentState!.validate()) {
//                                   context.read<LoginBloc>().add(
//                                         LoginUserEvent(
//                                           context: context,
//                                           username: _usernameController.text,
//                                           password: _passwordController.text,
//                                         ),
//                                       );
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.white,
//                                 foregroundColor: Colors.purple,
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 16),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               child: Text(
//                                 'Login',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),

//                           const SizedBox(height: 20),

//                           // ✅ Or Divider
//                           const Row(
//                             children: [
//                               Expanded(
//                                 child: Divider(
//                                   color: Colors.white70,
//                                   thickness: 1,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 8),
//                                 child: Text(
//                                   'OR',
//                                   style: TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Divider(
//                                   color: Colors.white70,
//                                   thickness: 1,
//                                 ),
//                               ),
//                             ],
//                           ),

//                           const SizedBox(height: 20),

//                           // ✅ Login with Google
//                           SizedBox(
//                             width: double.infinity,
//                             child: SignInButton(
//                               Buttons.Google,
//                               text: 'Sign in with Google',
//                               onPressed: () {
//                                 // TODO: Implement Google login
//                                 // context.read<LoginBloc>().add(
//                                 //       LoginWithGoogleEvent(context: context),
//                                 //     );
//                               },
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),

//                           const SizedBox(height: 12),

//                           // ✅ Login with Facebook
//                           SizedBox(
//                             width: double.infinity,
//                             child: SignInButton(
//                               Buttons.Facebook,
//                               text: 'Sign in with Facebook',
//                               onPressed: () {
//                                 // TODO: Implement Facebook login
//                                 // context.read<LoginBloc>().add(
//                                 //       LoginWithFacebookEvent(context: context),
//                                 //     );
//                               },
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),

//                           const SizedBox(height: 20),

//                           // ✅ Register Redirect
//                           Center(
//                             child: GestureDetector(
//                               onTap: () {
//                                 context.read<LoginBloc>().add(
//                                       NavigateRegisterScreenEvent(
//                                         destination: const RegisterView(),
//                                         context: context,
//                                       ),
//                                     );
//                               },
//                               child: Text(
//                                 'Don\'t have an account? Register here',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 30),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ✅ Reusable TextField Widget
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
//         labelStyle: const TextStyle(color: Colors.white70),
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

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:koselie/core/common/snackbar/snackbar.dart';
// import 'package:koselie/features/auth/presentation/view/register_view.dart';
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
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: BlocListener<LoginBloc, LoginState>(
//         listener: (context, state) {
//           if (state.isOtpSent) {
//             showMySnackBar(
//               context: context,
//               message: "OTP sent successfully. Check your email/phone.",
//               color: Colors.green,
//             );
//             Navigator.pop(context); // Close the modal after sending OTP
//           }
//           if (state.errorMessage.isNotEmpty) {
//             showMySnackBar(
//               context: context,
//               message: state.errorMessage,
//               color: Colors.red,
//             );
//           }
//         },
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFF8E2DE2),
//                 Color(0xFFEC008C),
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 10),
//                   Image.asset(
//                     'assets/logo/logo.png',
//                     height: 120,
//                     width: 130,
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     'Welcome back!',
//                     style: GoogleFonts.poppins(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             _buildTextField(
//                               controller: _usernameController,
//                               label: 'Username',
//                               icon: Icons.person,
//                             ),

//                             const SizedBox(height: 16),

//                             _buildTextField(
//                               controller: _passwordController,
//                               label: 'Password',
//                               icon: Icons.lock,
//                               isObscure: !_isPasswordVisible,
//                               suffixIcon: IconButton(
//                                 icon: Icon(
//                                   _isPasswordVisible
//                                       ? Icons.visibility
//                                       : Icons.visibility_off,
//                                   color: Colors.white70,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     _isPasswordVisible = !_isPasswordVisible;
//                                   });
//                                 },
//                               ),
//                             ),

//                             const SizedBox(height: 8),

//                             // ✅ Forgot Password Button
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: TextButton(
//                                 onPressed: () => _showForgotPasswordModal(),
//                                 child: Text(
//                                   "Forgot Password?",
//                                   style: GoogleFonts.poppins(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(height: 24),

//                             // ✅ Login Button
//                             SizedBox(
//                               width: double.infinity,
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   if (_formKey.currentState!.validate()) {
//                                     context.read<LoginBloc>().add(
//                                           LoginUserEvent(
//                                             context: context,
//                                             username: _usernameController.text,
//                                             password: _passwordController.text,
//                                           ),
//                                         );
//                                   }
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.white,
//                                   foregroundColor: Colors.purple,
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 16),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   'Login',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(height: 30),

//                             Center(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   context.read<LoginBloc>().add(
//                                         NavigateRegisterScreenEvent(
//                                           destination: const RegisterView(),
//                                           context: context,
//                                         ),
//                                       );
//                                 },
//                                 child: Text(
//                                   'Don\'t have an account? Register here',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 30),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ✅ Forgot Password Modal
//   void _showForgotPasswordModal() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "Forgot Password?",
//                 style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 "Enter your email or phone number to receive an OTP.",
//                 style: GoogleFonts.poppins(fontSize: 14),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _forgotPasswordController,
//                 decoration: InputDecoration(
//                   hintText: "Enter email or phone",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   prefixIcon: const Icon(Icons.email),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_forgotPasswordController.text.isNotEmpty) {
//                     context.read<LoginBloc>().add(
//                           ForgotPasswordRequested(
//                             email: _forgotPasswordController.text,
//                             context: context,
//                           ),
//                         );
//                   } else {
//                     showMySnackBar(
//                       context: context,
//                       message: "Please enter email or phone number",
//                       color: Colors.red,
//                     );
//                   }
//                 },
//                 child: const Text("Send OTP"),
//               ),
//               const SizedBox(height: 16),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // ✅ Reusable TextField Widget
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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8E2DE2), Color(0xFFEC008C)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Image.asset('assets/logo/logo.png', height: 120, width: 130),
              const SizedBox(height: 20),
              Text(
                'Welcome back!',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: _usernameController,
                          label: 'Username',
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock,
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
                                fontWeight: FontWeight.bold,
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
                              foregroundColor: Colors.purple,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
                                fontWeight: FontWeight.bold,
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

  // /// ✅ **Forgot Password Modal**
  // void _showForgotPasswordModal() {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (context) {
  //       return BlocBuilder<LoginBloc, LoginState>(
  //         builder: (context, state) {
  //           return Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(
  //                   "Forgot Password?",
  //                   style: GoogleFonts.poppins(
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Text(
  //                   "Enter your email or phone number to receive an OTP.",
  //                   style: GoogleFonts.poppins(fontSize: 14),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 const SizedBox(height: 16),
  //                 TextFormField(
  //                   controller: _forgotPasswordController,
  //                   decoration: InputDecoration(
  //                     hintText: "Enter email or phone",
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(12),
  //                     ),
  //                     prefixIcon: const Icon(Icons.email),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 16),
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
  //                   child: state.isLoading
  //                       ? const CircularProgressIndicator(color: Colors.white)
  //                       : const Text("Send OTP"),
  //                 ),
  //                 const SizedBox(height: 16),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  /// ✅ **Forgot Password Modal (Improved & Longer)**
  void _showForgotPasswordModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // ✅ Allows the modal to expand properly
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20)), // ✅ Slightly larger border radius
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor:
              0.6, // ✅ Increases modal height (60% of the screen height)
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// **🔹 Title**
                Text(
                  "Forgot Password?",
                  style: GoogleFonts.poppins(
                    fontSize: 20, // ✅ Slightly larger font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                /// **🔹 Instruction Text**
                Text(
                  "Enter your email or phone number to receive an OTP for password reset.",
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                /// **🔹 Input Field for Email or Phone**
                TextFormField(
                  controller: _forgotPasswordController,
                  keyboardType: TextInputType
                      .emailAddress, // ✅ Supports both email & phone inputs
                  decoration: InputDecoration(
                    hintText: "Enter email or phone",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                const SizedBox(height: 24),

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
                    backgroundColor: Colors.pink[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: context.watch<LoginBloc>().state.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Send OTP",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),

                /// **🔹 Additional Spacing for Better UX**
                const SizedBox(height: 30),

                /// **🔹 Close Button**
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) => value?.isEmpty ?? true ? 'Enter $label' : null,
    );
  }
}
