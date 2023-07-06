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
      create: (context) => AuthBloc(),
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
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    context.read<AuthBloc>().add(GoogleAuthenticate());
                    if (state is AuthInitial) {
                      return _buildGoogleSignButton(context);
                    }

                    if (state is AuthLoaded) {
                      Future.delayed(const Duration(seconds: 2), () {
                        context.read<AuthBloc>().add(GoToHome());
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                      });
                      return Text("Bienvenue ${state.user.displayName}");
                    }
                    if (state is AuthError) {
                      return Column(
                        children: [
                          Text(state.message),
                          _buildGoogleSignButton(context),
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  },
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
