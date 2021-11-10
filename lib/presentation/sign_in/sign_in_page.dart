import 'package:crypto_wallet_application/application/sign_in_form/sign_in_form_bloc.dart';
import 'package:crypto_wallet_application/constants.dart';
import 'package:crypto_wallet_application/injection_container.dart';
import 'package:crypto_wallet_application/presentation/sign_in/widgets/sign_in_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Sign In",
            style: themeData.textTheme.headline4!.apply(color: COLOR_WHITE),
          ),
        ),
        body: BlocProvider<SignInFormBloc>(
          create: (context) => getIt<SignInFormBloc>(),
          child: SignInForm(),
        ),
      ),
    );
  }
}
