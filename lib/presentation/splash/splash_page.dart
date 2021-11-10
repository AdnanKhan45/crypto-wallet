import 'package:crypto_wallet_application/application/auth_bloc.dart';
import 'package:crypto_wallet_application/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          authenticated: (_) {
            Navigator.pushReplacementNamed(context, PageConst.overviewPage);

          },
          unauthenticated: (_) {
            Navigator.pushReplacementNamed(context, PageConst.signInPage);
          },
        );
      },
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
