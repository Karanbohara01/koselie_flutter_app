// import 'package:flutter/material.dart';
// import 'package:koselie/view/onboarding_view.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _logoOpacity;
//   late Animation<double> _textSlide;
//   late Animation<double> _taglineSlide;

//   @override
//   void initState() {
//     super.initState();

//     // Animation controller
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );

//     // Animation for logo opacity
//     _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//     );

//     // Animation for main text sliding up
//     _textSlide = Tween<double>(begin: 100, end: 0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     );

//     // Animation for tagline sliding up
//     _taglineSlide = Tween<double>(begin: 50, end: 0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.5, 1, curve: Curves.easeOut),
//       ),
//     );

//     // Start the animation
//     _controller.forward();

//     // Delay before navigating to the OnboardingScreen
//     Future.delayed(const Duration(seconds: 4), () {
//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OnboardingScreen(),
//           ),
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.pink, Colors.pinkAccent],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: AnimatedBuilder(
//           animation: _controller,
//           builder: (context, child) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Animated logo
//                 Opacity(
//                   opacity: _logoOpacity.value,
//                   child: Image.asset(
//                     'assets/logo/logo.png',
//                     height: size.height * 0.25,
//                     width: size.width * 0.5,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 // Animated title
//                 Transform.translate(
//                   offset: Offset(0, _textSlide.value),
//                   child: const Text(
//                     'Welcome to Koselie',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 // Animated tagline
//                 Transform.translate(
//                   offset: Offset(0, _taglineSlide.value),
//                   child: const Text(
//                     'Your journey begins here.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white70,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 // Pulsating loading indicator
//                 ScaleTransition(
//                   scale: Tween<double>(begin: 0.8, end: 1.2).animate(
//                     CurvedAnimation(
//                       parent: _controller,
//                       curve: Curves.easeInOut,
//                     ),
//                   ),
//                   child: const CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
