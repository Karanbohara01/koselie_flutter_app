// import 'package:flutter/material.dart';
// import 'package:koselie/core/common/snackbar/snackbar.dart';
// import 'package:koselie/view/bottom_navigation_screens/dashboard_view.dart';
// import 'package:koselie/view/signup_view.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: SafeArea(
//           child: Container(
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.pink, Colors.pinkAccent],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Stack(
//               children: [
//                 const Positioned(
//                   top: 50,
//                   left: 150,
//                   child: Image(
//                     image: AssetImage('assets/logo/logo.png'),
//                     height: 100,
//                     width: 100,
//                   ),
//                 ),
//                 Center(
//                   child: SingleChildScrollView(
//                     child: Container(
//                       padding: const EdgeInsets.all(24),
//                       margin: const EdgeInsets.symmetric(horizontal: 20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 15,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           _header(),
//                           const SizedBox(height: 20),
//                           _inputField(context),
//                           const SizedBox(height: 10),
//                           _forgotPassword(context),
//                           const SizedBox(height: 20),
//                           _signup(context),
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

//   // Header with welcome message
//   Widget _header() {
//     return const Column(
//       children: [
//         Text(
//           "Welcome Back",
//           style: TextStyle(
//             fontSize: 36,
//             fontWeight: FontWeight.bold,
//             color: Colors.pink,
//           ),
//         ),
//         SizedBox(height: 10),
//         Text(
//           "Enter your credentials to login",
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.black54,
//           ),
//         ),
//       ],
//     );
//   }

//   // Input fields for username and password
//   Widget _inputField(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         TextField(
//           decoration: InputDecoration(
//             hintText: "username",
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(18),
//               borderSide: BorderSide.none,
//             ),
//             fillColor: Colors.grey[200],
//             filled: true,
//             prefixIcon: const Icon(Icons.person, color: Colors.pink),
//           ),
//         ),
//         const SizedBox(height: 10),
//         TextField(
//           obscureText: true,
//           decoration: InputDecoration(
//             hintText: "Password",
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(18),
//               borderSide: BorderSide.none,
//             ),
//             fillColor: Colors.grey[200],
//             filled: true,
//             prefixIcon: const Icon(Icons.lock, color: Colors.pink),
//           ),
//         ),
//         const SizedBox(height: 20),
//         Builder(builder: (context) {
//           return TextButton(
//             onPressed: () {
//               showMySnackBar(context, message: "message");
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const MyDashboardView()),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               shape: const StadiumBorder(),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               backgroundColor: Colors.pink,
//               shadowColor: Colors.pinkAccent,
//               elevation: 5,
//             ),
//             child: const Text(
//               // showMySnackBar(, "Login Successful"),

//               "Login",
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//               ),
//             ),
//           );
//         }),
//       ],
//     );
//   }

//   // Forgot password link
//   Widget _forgotPassword(BuildContext context) {
//     return TextButton(
//       onPressed: () {},
//       child: const Text(
//         "Forgot password?",
//         style: TextStyle(
//           color: Colors.pink,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }

//   // Link to navigate to the signup screen
//   Widget _signup(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           "Don't have an account? ",
//           style: TextStyle(color: Colors.black87),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => SignupScreen()),
//             );
//           },
//           child: const Text(
//             "Sign Up",
//             style: TextStyle(
//               color: Colors.pink,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
