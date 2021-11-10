
import 'package:crypto_wallet_application/constants.dart';
import 'package:crypto_wallet_application/presentation/crypto_wallet/overview_page.dart';
import 'package:crypto_wallet_application/presentation/sign_in/sign_in_page.dart';
import 'package:crypto_wallet_application/presentation/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case "/": {
        return routeBuilder(widget: SplashPage());
      }
      case PageConst.signInPage: {
        return routeBuilder(widget: SignInPage());
      }
      case PageConst.overviewPage: {
        return routeBuilder(widget: OverviewPage());
      }
      default: {
        return routeBuilder(widget: ErrorPage());
      }
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error Page"),
      ),
      body: Center(
        child: Text(ErrorConst.errorPage),
      ),
    );
  }
}

MaterialPageRoute routeBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}