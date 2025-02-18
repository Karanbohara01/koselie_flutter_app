import 'package:flutter/material.dart';
import 'package:koselie/features/auth/presentation/view/login_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/logo/logo.png',
      'title': 'Connect with Shoppers!',
      'subtitle': 'Join groups, follow trends, spread love',
    },
    {
      'image': 'assets/logo/logo.png',
      'title': 'Discover & Shop',
      'subtitle': 'Share and shop your favorites easily',
    },
    {
      'image': 'assets/logo/logo.png',
      'title': 'Shop & Connect',
      'subtitle': 'Explore and shop in a snap!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ✅ Onboarding Image
                        Image.asset(
                          onboardingData[index]['image']!,
                          height: size.height * 0.15,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 30),

                        // ✅ Title
                        Center(
                          child: Text(
                            onboardingData[index]['title']!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // ✅ Subtitle
                        Center(
                          child: Text(
                            onboardingData[index]['subtitle']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // ✅ Bottom Navigation Controls
              Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ✅ Skip Button
                    TextButton(
                      onPressed: () {
                        _pageController.jumpToPage(onboardingData.length - 1);
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // ✅ Page Indicator Dots
                    Row(
                      children: List.generate(
                        onboardingData.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 12 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.white
                                : Colors.white38,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),

                    // ✅ Next / Done Button
                    TextButton(
                      onPressed: () {
                        if (_currentPage == onboardingData.length - 1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginView(),
                            ),
                          );
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Text(
                        _currentPage == onboardingData.length - 1
                            ? 'Done'
                            : 'Next',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
