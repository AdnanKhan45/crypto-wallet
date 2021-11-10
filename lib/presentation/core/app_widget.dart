
import 'package:crypto_wallet_application/application/auth_bloc.dart';
import 'package:crypto_wallet_application/constants.dart';
import 'package:crypto_wallet_application/injection_container.dart';
import 'package:crypto_wallet_application/presentation/sign_in/sign_in_page.dart';
import 'package:crypto_wallet_application/presentation/splash/splash_page.dart';
import 'package:crypto_wallet_application/routes/on_generate_route.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = window.physicalSize.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()..add(AuthEvent.authCheckRequested()))
      ],
      child: MaterialApp(
        title: "Crypto Wallet",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT
        ),
        initialRoute: "/",
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return SplashPage();
          }
        },
      ),
    );
  }
}
