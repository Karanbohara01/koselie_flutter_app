// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/features/auth/presentation/view/register_view.dart';
// import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';

// class LoginView extends StatelessWidget {
//   LoginView({super.key});

//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Koselie'),
//         backgroundColor: Colors.black,
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // Adding the logo
//                     Image.asset(
//                       'assets/logo/logo.png',
//                       height: 120,
//                       width: 130,
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       'Welcome back!',
//                       style:
//                           Theme.of(context).textTheme.headlineSmall?.copyWith(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.pink,
//                               ),
//                     ),
//                     const SizedBox(height: 30),
//                     TextFormField(
//                       key: const ValueKey('username'),
//                       controller: _usernameController,
//                       decoration: InputDecoration(
//                         labelText: 'username',
//                         prefixIcon:
//                             const Icon(Icons.person, color: Colors.pink),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: const BorderSide(color: Colors.pink),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 18),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your username';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       key: const ValueKey('password'),
//                       controller: _passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         prefixIcon: const Icon(Icons.lock, color: Colors.pink),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: const BorderSide(color: Colors.pink),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 18),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your password';
//                         }
//                         if (value.length < 6) {
//                           return 'Password must be at least 6 characters long';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 24),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             context.read<LoginBloc>().add(
//                                   LoginUserEvent(
//                                     context: context, // only for testing
//                                     username: _usernameController.text,
//                                     password: _passwordController.text,
//                                   ),
//                                 );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.pink,
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: const Text(
//                           'Login',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Center(
//                       child: GestureDetector(
//                         onTap: () {
//                           // only for testing
//                           context.read<LoginBloc>().add(
//                                 NavigateRegisterScreenEvent(
//                                   destination: const RegisterView(),
//                                   context: context,
//                                 ),
//                               );
//                         },
//                         child: const Text(
//                           'Don\'t have an account? Register here',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.pink,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/features/auth/presentation/view/register_view.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // ✅ Make full screen
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity, // ✅ Full screen coverage
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                // ✅ Logo
                Image.asset(
                  'assets/logo/logo.png',
                  height: 120,
                  width: 130,
                ),
                const SizedBox(height: 20),

                // ✅ Welcome Text
                const Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                // ✅ Form Fields
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // ✅ Username Field
                          _buildTextField(
                              controller: _usernameController,
                              label: 'Username',
                              icon: Icons.person),

                          const SizedBox(height: 16),

                          // ✅ Password Field
                          _buildTextField(
                              controller: _passwordController,
                              label: 'Password',
                              icon: Icons.lock,
                              isObscure: true),

                          const SizedBox(height: 24),

                          // ✅ Login Button
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ✅ Register Redirect
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
                              child: const Text(
                                'Don\'t have an account? Register here',
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
