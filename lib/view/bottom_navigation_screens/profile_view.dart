import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Ensures content is centered vertically
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Makes buttons full width
            children: [
              const Text(
                'Login Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                  height:
                      20), // Adds spacing between the title and the text fields
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12), // Adds spacing between text fields
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  // Masks the password input
                ),
              ),
              const SizedBox(
                  height: 20), // Adds spacing between text fields and buttons
              ElevatedButton(
                onPressed: () {
                  // Login logic goes here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login button pressed')),
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 12), // Adds spacing between buttons
              ElevatedButton(
                onPressed: () {
                  // Register logic goes here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Register button pressed')),
                  );
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
