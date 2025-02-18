// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:koselie/features/auth/presentation/view/login_view.dart';
// import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:permission_handler/permission_handler.dart';

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

//   Future<void> checkCameraPermission() async {
//     if (await Permission.camera.request().isRestricted ||
//         await Permission.camera.request().isDenied) {
//       await Permission.camera.request();
//     }
//   }

//   File? _img;
//   Future _browseImage(ImageSource imageSource) async {
//     try {
//       final image = await ImagePicker().pickImage(source: imageSource);
//       if (image != null) {
//         setState(() {
//           _img = File(image.path);
//           // Send image to server
//           context.read<RegisterBloc>().add(
//                 UploadImage(file: _img!),
//               );
//         });
//       } else {
//         return;
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Register',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.pink,
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
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
//                 InkWell(
//                   onTap: () {
//                     showModalBottomSheet(
//                       backgroundColor: Colors.grey[300],
//                       context: context,
//                       isScrollControlled: true,
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(20),
//                         ),
//                       ),
//                       builder: (context) => Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             ElevatedButton.icon(
//                               onPressed: () {
//                                 checkCameraPermission();
//                                 _browseImage(ImageSource.camera);
//                                 Navigator.pop(context);
//                               },
//                               icon: const Icon(Icons.camera),
//                               label: const Text('Camera'),
//                             ),
//                             ElevatedButton.icon(
//                               onPressed: () {
//                                 _browseImage(ImageSource.gallery);
//                                 Navigator.pop(context);
//                               },
//                               icon: const Icon(Icons.image),
//                               label: const Text('Gallery'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   child: SizedBox(
//                     height: 200,
//                     width: 200,
//                     child: CircleAvatar(
//                       backgroundImage: _img != null
//                           ? FileImage(_img!)
//                           : const AssetImage('assets/images/pushpa.jpg')
//                               as ImageProvider,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20.0,
//                     vertical: 30.0,
//                   ),
//                   child: Form(
//                     key: _key,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Create Your Account',
//                           style: Theme.of(context)
//                               .textTheme
//                               .headlineSmall
//                               ?.copyWith(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.pink,
//                               ),
//                         ),
//                         const SizedBox(height: 20),
//                         TextFormField(
//                           controller: _usernameController,
//                           decoration: InputDecoration(
//                             labelText: 'User Name',
//                             prefixIcon:
//                                 const Icon(Icons.person, color: Colors.pink),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           validator: (value) => value?.isEmpty ?? true
//                               ? 'Please enter a user name'
//                               : null,
//                         ),
//                         const SizedBox(height: 16),
//                         TextFormField(
//                           controller: _emailController,
//                           decoration: InputDecoration(
//                             labelText: 'Email',
//                             prefixIcon:
//                                 const Icon(Icons.email, color: Colors.pink),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value?.isEmpty ?? true) {
//                               return 'Please enter an email';
//                             }
//                             final emailRegex =
//                                 RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+');
//                             return emailRegex.hasMatch(value!)
//                                 ? null
//                                 : 'Enter a valid email';
//                           },
//                         ),
//                         const SizedBox(height: 16),
//                         TextFormField(
//                           controller: _passwordController,
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                             prefixIcon:
//                                 const Icon(Icons.lock, color: Colors.pink),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           obscureText: true,
//                           validator: (value) {
//                             if (value?.isEmpty ?? true) {
//                               return 'Please enter a password';
//                             }
//                             if (value!.length < 6) {
//                               return 'Password must be at least 6 characters';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 24),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               if (_key.currentState!.validate()) {
//                                 final registerState =
//                                     context.read<RegisterBloc>().state;

//                                 context.read<RegisterBloc>().add(
//                                       RegisterUser(
//                                         context: context,
//                                         email: _emailController.text,
//                                         username: _usernameController.text,
//                                         password: _passwordController.text,
//                                         image: registerState.imageName,
//                                       ),
//                                     );
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.black,
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child: const Text(
//                               'Register',
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'Already have an account? ',
//                               style: TextStyle(fontSize: 14),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => LoginView()),
//                                 );
//                               },
//                               child: const Text(
//                                 'Login',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.pink,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
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
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  File? _img;

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
        title: const Text('Register'),
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
                MaterialPageRoute(builder: (context) => LoginView()),
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
                Color(0xFF6A0DAD), // Dark Purple
                Color(0xFF9C27B0), // Light Purple
                Color(0xFFEC407A), // Pinkish Gradient
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
                            const Text(
                              'Create Your Account',
                              style: TextStyle(
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
                                isObscure: true),

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
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // ✅ Login Redirect
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginView()),
                                  );
                                },
                                child: const Text(
                                  'Already have an account? Login',
                                  style: TextStyle(
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
  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      required IconData icon,
      bool isObscure = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white),
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
