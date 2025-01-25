// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/features/auth/presentation/view/login_view.dart';
// import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';

// class RegisterView extends StatelessWidget {
//   const RegisterView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final usernameController = TextEditingController();
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();
//     final formKey = GlobalKey<FormState>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Register User'),
//         centerTitle: true,
//         backgroundColor: Colors.pink, // Adding a color for the AppBar
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Create an Account',
//                   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.pink,
//                       ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: usernameController,
//                   decoration: InputDecoration(
//                     labelText: 'User Name',
//                     labelStyle: const TextStyle(fontSize: 16),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.pink),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 18),
//                   ),
//                   validator: (value) => value?.isEmpty ?? true
//                       ? 'Please enter a user name'
//                       : null,
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     labelStyle: const TextStyle(fontSize: 16),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: Colors.pink,
//                       ),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 18),
//                   ),
//                   obscureText: true,
//                   validator: (value) =>
//                       value?.isEmpty ?? true ? 'Please enter a password' : null,
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     labelStyle: const TextStyle(fontSize: 16),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.pink),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 18),
//                   ),
//                   validator: (value) =>
//                       value?.isEmpty ?? true ? 'Please enter an email' : null,
//                 ),
//                 const SizedBox(height: 24),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (formKey.currentState?.validate() ?? false) {
//                         context.read<RegisterBloc>().add(
//                               RegisterUser(
//                                 context: context,
//                                 username: usernameController.text,
//                                 email: emailController.text,
//                                 password: passwordController.text,
//                               ),
//                             );
//                         // After successful registration, navigate to login screen
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => LoginView()),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink, // Button background color
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: const Text(
//                       'Register',
//                       style: TextStyle(fontSize: 16),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/features/auth/presentation/view/login_view.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Create Your Account',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'User Name',
                    prefixIcon: const Icon(Icons.person, color: Colors.pink),
                    labelStyle: const TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                  ),
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Please enter a user name'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email, color: Colors.pink),
                    labelStyle: const TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter an email';
                    }
                    final emailRegex = RegExp(
                        r'^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+'); // Basic email validation
                    return emailRegex.hasMatch(value!)
                        ? null
                        : 'Enter a valid email';
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock, color: Colors.pink),
                    labelStyle: const TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.pink,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a password';
                    }
                    if (value!.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        context.read<RegisterBloc>().add(
                              RegisterUser(
                                context: context,
                                username: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginView(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
