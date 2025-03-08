// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:koselie/features/auth/presentation/view/login_view.dart';
// import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';

// class RegisterView extends StatefulWidget {
//   const RegisterView({super.key});

//   @override
//   State<RegisterView> createState() => _RegisterViewState();
// }

// class _RegisterViewState extends State<RegisterView> {
//   final _key = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   File? _img;

//   Future<void> _browseImage(ImageSource imageSource) async {
//     try {
//       final image = await ImagePicker().pickImage(source: imageSource);
//       if (image != null) {
//         setState(() {
//           _img = File(image.path);
//           context.read<RegisterBloc>().add(UploadImage(file: _img!));
//         });
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true, // ✅ Ensure full-screen effect
//       appBar: AppBar(
//         title: const Text('Register'),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: BlocListener<RegisterBloc, RegisterState>(
//         listener: (context, state) {
//           if (state.isSuccess) {
//             Future.delayed(const Duration(seconds: 1), () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginView()),
//               );
//             });
//           }
//         },
//         child: Container(
//           width: double.infinity,
//           height: double.infinity, // ✅ Ensure full height
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFF6A0DAD), // Dark Purple
//                 Color(0xFF9C27B0), // Light Purple
//                 Color(0xFFEC407A), // Pinkish Gradient
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),

//                   // ✅ Profile Picture Picker
//                   InkWell(
//                     onTap: () {
//                       showModalBottomSheet(
//                         backgroundColor: Colors.white,
//                         context: context,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.vertical(top: Radius.circular(20)),
//                         ),
//                         builder: (context) => Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   _browseImage(ImageSource.camera);
//                                   Navigator.pop(context);
//                                 },
//                                 icon: const Icon(Icons.camera),
//                                 label: const Text('Camera'),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.pink,
//                                   foregroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               ),
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   _browseImage(ImageSource.gallery);
//                                   Navigator.pop(context);
//                                 },
//                                 icon: const Icon(Icons.image),
//                                 label: const Text('Gallery'),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.black,
//                                   foregroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     child: CircleAvatar(
//                       radius: 50,
//                       backgroundImage: _img != null
//                           ? FileImage(_img!)
//                           : const AssetImage('assets/images/pushpa.jpg')
//                               as ImageProvider,
//                       backgroundColor: Colors.grey[300],
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Form(
//                         key: _key,
//                         child: Column(
//                           children: [
//                             const Text(
//                               'Create Your Account',
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(height: 20),

//                             // ✅ Username Field
//                             _buildTextField(
//                                 controller: _usernameController,
//                                 label: 'User Name',
//                                 icon: Icons.person),

//                             const SizedBox(height: 16),

//                             // ✅ Email Field
//                             _buildTextField(
//                                 controller: _emailController,
//                                 label: 'Email',
//                                 icon: Icons.email),

//                             const SizedBox(height: 16),

//                             // ✅ Password Field
//                             _buildTextField(
//                                 controller: _passwordController,
//                                 label: 'Password',
//                                 icon: Icons.lock,
//                                 isObscure: true),

//                             const SizedBox(height: 24),

//                             // ✅ Register Button
//                             SizedBox(
//                               width: double.infinity,
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   if (_key.currentState!.validate()) {
//                                     final registerState =
//                                         context.read<RegisterBloc>().state;

//                                     context.read<RegisterBloc>().add(
//                                           RegisterUser(
//                                             context: context,
//                                             email: _emailController.text,
//                                             username: _usernameController.text,
//                                             password: _passwordController.text,
//                                             image: registerState.imageName,
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
//                                 child: const Text(
//                                   'Register',
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(height: 20),

//                             // ✅ Login Redirect
//                             Center(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => LoginView()),
//                                   );
//                                 },
//                                 child: const Text(
//                                   'Already have an account? Login',
//                                   style: TextStyle(
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

//   // ✅ Reusable TextField Widget
//   Widget _buildTextField(
//       {required TextEditingController controller,
//       required String label,
//       required IconData icon,
//       bool isObscure = false}) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isObscure,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(color: Colors.white70),
//         prefixIcon: Icon(icon, color: Colors.white),
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

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_signin_button/button_list.dart';
// import 'package:flutter_signin_button/button_view.dart';
// import 'package:google_fonts/google_fonts.dart'; // For Google Fonts
// import 'package:image_picker/image_picker.dart';
// import 'package:koselie/features/auth/presentation/view/login_view.dart';
// import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';

// class RegisterView extends StatefulWidget {
//   const RegisterView({super.key});

//   @override
//   State<RegisterView> createState() => _RegisterViewState();
// }

// class _RegisterViewState extends State<RegisterView> {
//   final _key = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   File? _img;

//   Future<void> _browseImage(ImageSource imageSource) async {
//     try {
//       final image = await ImagePicker().pickImage(source: imageSource);
//       if (image != null) {
//         setState(() {
//           _img = File(image.path);
//           context.read<RegisterBloc>().add(UploadImage(file: _img!));
//         });
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true, // ✅ Ensure full-screen effect
//       appBar: AppBar(
//         title: Text(
//           'Koselie',
//           style: GoogleFonts.poppins(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: BlocListener<RegisterBloc, RegisterState>(
//         listener: (context, state) {
//           if (state.isSuccess) {
//             Future.delayed(const Duration(seconds: 1), () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const LoginView()),
//               );
//             });
//           }
//         },
//         child: Container(
//           width: double.infinity,
//           height: double.infinity, // ✅ Ensure full height
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFF8E2DE2), // Dark Purple
//                 Color(0xFFEC008C), // Pinkish Gradient
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),

//                   // ✅ Profile Picture Picker
//                   InkWell(
//                     onTap: () {
//                       showModalBottomSheet(
//                         backgroundColor: Colors.white,
//                         context: context,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.vertical(top: Radius.circular(20)),
//                         ),
//                         builder: (context) => Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   _browseImage(ImageSource.camera);
//                                   Navigator.pop(context);
//                                 },
//                                 icon: const Icon(Icons.camera),
//                                 label: const Text('Camera'),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.pink,
//                                   foregroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               ),
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   _browseImage(ImageSource.gallery);
//                                   Navigator.pop(context);
//                                 },
//                                 icon: const Icon(Icons.image),
//                                 label: const Text('Gallery'),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.black,
//                                   foregroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     child: CircleAvatar(
//                       radius: 50,
//                       backgroundImage: _img != null
//                           ? FileImage(_img!)
//                           : const AssetImage('assets/images/pushpa.jpg')
//                               as ImageProvider,
//                       backgroundColor: Colors.grey[300],
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Form(
//                         key: _key,
//                         child: Column(
//                           children: [
//                             Text(
//                               'Create Your Account',
//                               style: GoogleFonts.poppins(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(height: 20),

//                             // ✅ Username Field
//                             _buildTextField(
//                                 controller: _usernameController,
//                                 label: 'User Name',
//                                 icon: Icons.person),

//                             const SizedBox(height: 16),

//                             // ✅ Email Field
//                             _buildTextField(
//                                 controller: _emailController,
//                                 label: 'Email',
//                                 icon: Icons.email),

//                             const SizedBox(height: 16),

//                             // ✅ Password Field
//                             _buildTextField(
//                                 controller: _passwordController,
//                                 label: 'Password',
//                                 icon: Icons.lock,
//                                 isObscure: true),

//                             const SizedBox(height: 24),

//                             // ✅ Register Button
//                             SizedBox(
//                               width: double.infinity,
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   if (_key.currentState!.validate()) {
//                                     final registerState =
//                                         context.read<RegisterBloc>().state;

//                                     context.read<RegisterBloc>().add(
//                                           RegisterUser(
//                                             context: context,
//                                             email: _emailController.text,
//                                             username: _usernameController.text,
//                                             password: _passwordController.text,
//                                             image: registerState.imageName,
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
//                                   'Register',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(height: 20),

//                             // ✅ OR Divider
//                             const Row(
//                               children: [
//                                 Expanded(
//                                   child: Divider(
//                                     color: Colors.white70,
//                                     thickness: 1,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 8),
//                                   child: Text(
//                                     'OR',
//                                     style: TextStyle(
//                                       color: Colors.white70,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Divider(
//                                     color: Colors.white70,
//                                     thickness: 1,
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             const SizedBox(height: 20),

//                             // ✅ Sign up with Google
//                             SizedBox(
//                               width: double.infinity,
//                               child: SignInButton(
//                                 Buttons.Google,
//                                 text: 'Sign up with Google',
//                                 onPressed: () {
//                                   // // TODO: Implement Google signup
//                                   // context.read<RegisterBloc>().add(
//                                   //       SignupWithGoogleEvent(context: context),
//                                   //     );
//                                 },
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(height: 12),

//                             // ✅ Sign up with Facebook
//                             SizedBox(
//                               width: double.infinity,
//                               child: SignInButton(
//                                 Buttons.Facebook,
//                                 text: 'Sign up with Facebook',
//                                 onPressed: () {
//                                   // TODO: Implement Facebook signup
//                                   // context.read<RegisterBloc>().add(
//                                   //       SignupWithFacebookEvent(
//                                   //           context: context),
//                                   //     );
//                                 },
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(height: 20),

//                             // ✅ Login Redirect
//                             Center(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             const LoginView()),
//                                   );
//                                 },
//                                 child: Text(
//                                   'Already have an account? Login',
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

//   // ✅ Reusable TextField Widget
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     bool isObscure = false,
//   }) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isObscure,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(color: Colors.white70),
//         prefixIcon: Icon(icon, color: Colors.white),
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart'; // For Google Fonts
import 'package:image_picker/image_picker.dart';
import 'package:koselie/features/auth/presentation/view/login_view.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _key = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  File? _img;
  bool _isPasswordVisible = false; // Track password visibility
  bool _isConfirmPasswordVisible = false; // Track confirm password visibility

  Future<void> _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          context.read<RegisterBloc>().add(UploadImage(file: _img!));
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // ✅ Ensure full-screen effect
      appBar: AppBar(
        title: Text(
          'Koselie',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            });
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity, // ✅ Ensure full height
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF8E2DE2), // Dark Purple
                Color(0xFFEC008C), // Pinkish Gradient
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // ✅ Profile Picture Picker
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  _browseImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.camera),
                                label: const Text('Camera'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _browseImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.image),
                                label: const Text('Gallery'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _img != null
                          ? FileImage(_img!)
                          : const AssetImage('assets/images/pushpa.jpg')
                              as ImageProvider,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _key,
                        child: Column(
                          children: [
                            Text(
                              'Create Your Account',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // ✅ Username Field
                            _buildTextField(
                                controller: _usernameController,
                                label: 'User Name',
                                icon: Icons.person),

                            const SizedBox(height: 16),

                            // ✅ Email Field
                            _buildTextField(
                                controller: _emailController,
                                label: 'Email',
                                icon: Icons.email),

                            const SizedBox(height: 16),

                            // ✅ Password Field
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

                            const SizedBox(height: 16),

                            // ✅ Confirm Password Field
                            _buildTextField(
                              controller: _confirmPasswordController,
                              label: 'Confirm Password',
                              icon: Icons.lock,
                              isObscure: !_isConfirmPasswordVisible,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isConfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white70,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isConfirmPasswordVisible =
                                        !_isConfirmPasswordVisible;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 24),

                            // ✅ Register Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_key.currentState!.validate()) {
                                    final registerState =
                                        context.read<RegisterBloc>().state;

                                    context.read<RegisterBloc>().add(
                                          RegisterUser(
                                            context: context,
                                            email: _emailController.text,
                                            username: _usernameController.text,
                                            password: _passwordController.text,
                                            image: registerState.imageName,
                                          ),
                                        );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.purple,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Register',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // ✅ OR Divider
                            const Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.white70,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.white70,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // ✅ Login Redirect
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginView()),
                                  );
                                },
                                child: Text(
                                  'Already have an account? Login',
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
        ),
      ),
    );
  }

  // ✅ Reusable TextField Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isObscure = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator ??
          (value) => value?.isEmpty ?? true ? 'Enter $label' : null,
    );
  }
}
