// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';

// class RegisterView extends StatefulWidget {
//   const RegisterView({super.key});

//   @override
//   State<RegisterView> createState() => _RegisterViewState();
// }

// class _RegisterViewState extends State<RegisterView> {
//   final _gap = const SizedBox(height: 8);
//   final _key = GlobalKey<FormState>();
//   final _userNameController = TextEditingController(text: '');
//   final _emailController = TextEditingController(text: '');
//   final _passwordController = TextEditingController(text: '');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: BlocBuilder<RegisterBloc, RegisterState>(
//           builder: (context, state) {
//             return const Text('Register User');
//           },
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8),
//             child: Form(
//               key: _key,
//               child: Column(
//                 children: [
//                   const SizedBox(height: 25),
//                   TextFormField(
//                     controller: _userNameController,
//                     decoration: const InputDecoration(
//                       labelText: 'User Name',
//                     ),
//                     validator: ((value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter first name';
//                       }
//                       return null;
//                     }),
//                   ),
//                   const SizedBox(height: 25),
//                   TextFormField(
//                     controller: _passwordController,
//                     decoration: const InputDecoration(
//                       labelText: 'Password',
//                     ),
//                     validator: ((value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter password.';
//                       }
//                       return null;
//                     }),
//                   ),
//                   _gap,
//                   TextFormField(
//                     controller: _emailController,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       labelText: 'Email',
//                     ),
//                     validator: ((value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter email';
//                       }
//                       return null;
//                     }),
//                   ),
//                   _gap,
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (_key.currentState!.validate()) {
//                           context.read<RegisterBloc>().add(
//                                 RegisterUser(
//                                   context: context,
//                                   userName: _userNameController.text,
//                                   email: _emailController.text,
//                                   password: _passwordController.text,
//                                 ),
//                               );
//                         }
//                       },
//                       child: const Text('Register'),
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
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/features/auth/presentation/view/login_view.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register User'),
        centerTitle: true,
        backgroundColor: Colors.pink, // Adding a color for the AppBar
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create an Account',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    labelText: 'User Name',
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
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter a password' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter an email' : null,
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
                                userName: userNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                        // After successful registration, navigate to login screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink, // Button background color
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 16),
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
}
