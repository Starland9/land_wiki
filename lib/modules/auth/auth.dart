import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_wiki/modules/home/home.dart';
import 'package:sign_button/sign_button.dart';

import 'bloc/auth_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(GoogleAuthenticate()),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  "assets/icon.png",
                  height: 200,
                ),
                const Text(
                  "Land Wiki",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const Spacer(),
                const Text(
                  "Trouve ce que tu veux !",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoaded) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                    }
                    if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                        duration: const Duration(seconds: 2),
                      ));
                    }
                  },
                  child: BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) {
                      if (state is AuthInitial) {
                        return _buildGoogleSignButton(context);
                      }

                      if (state is AuthError) {
                        return Column(
                          children: [
                            _buildGoogleSignButton(context),
                          ],
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SignInButton _buildGoogleSignButton(BuildContext context) {
    return SignInButton(
      buttonType: ButtonType.google,
      onPressed: () => context.read<AuthBloc>().add(GoogleAuthenticate()),
      btnText: "Continuer avec Google",
      buttonSize: ButtonSize.large,
      width: 260,
    );
  }
}
