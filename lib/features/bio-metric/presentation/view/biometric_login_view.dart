import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/features/bio-metric/domain/repository/biometric_repository.dart';
import 'package:koselie/features/bio-metric/presentation/view_model/biometric_bloc.dart';

class BiometricLoginView extends StatelessWidget {
  const BiometricLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BiometricBloc(
        biometricRepository: BiometricRepository(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Biometric Authentication"),
          centerTitle: true,
        ),
        body: Center(
          child: BlocBuilder<BiometricBloc, BiometricState>(
            builder: (context, state) {
              if (state.isAuthenticated) {
                return const Text(
                  "Authenticated ✅",
                  style: TextStyle(fontSize: 18, color: Colors.green),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Authenticate using your fingerprint or face",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  IconButton(
                    icon: const Icon(Icons.fingerprint, size: 50),
                    onPressed: () {
                      context.read<BiometricBloc>().authenticate();
                    },
                  ),
                  if (state.hasError)
                    const Text(
                      "Authentication Failed ❌",
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
