import 'package:crypto_wallet_application/application/auth_bloc.dart';
import 'package:crypto_wallet_application/application/sign_in_form/sign_in_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    final provider = BlocProvider.of<SignInFormBloc>(context);
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
              () => () {},
              (either) =>
              either.fold((failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: failure.map(
                      cancelledByUser: (_) => Text("Cancelled"),
                      serverError: (_) => Text("Server Error"),
                      emailAlreadyInUse: (_) => Text("Email Already in use"),
                      invalidEmailAndPasswordCombination: (_) => Text("Invalid Email and Password Combination"),
                    ),
                  ),
                );
              }, (_) {
                Navigator.pushReplacementNamed(context, PageConst.overviewPage);
                BlocProvider.of<AuthBloc>(context).add(AuthEvent.authCheckRequested());
              }
              ),
        );
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              Center(
                child: Text(
                  "💰",
                  style: TextStyle(fontSize: 120),
                ),
              ),
              verticalSpace(10),
              TextFormField(
                controller: _emailController,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                onChanged: (value) {
                  provider.add(SignInFormEvent.emailChanged(value));
                },
                validator: (_) =>
                    provider.state.emailAddress.value.fold(
                          (f) => f.maybeMap(invalidEmail: (_) => "Invalid Email", orElse: () => null),
                          (_) => null,
                    ),
              ),
              verticalSpace(10),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outlined),
                ),
                onChanged: (value) {
                  provider.add(SignInFormEvent.passwordChanged(value));
                },
                validator: (_) =>
                    provider.state.password.value.fold((f) => f.maybeMap(shortPassword: (_) => "Short password", orElse: () => null), (r) => null),
              ),
              verticalSpace(15),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(onPressed: () {
                      provider.add(SignInFormEvent.signInWithEmailAndPasswordPressed());
                    }, child: Text("Sign In"),),
                  ),
              horizontalSpace(5),
              Expanded(
                child: ElevatedButton(onPressed: () {
                  provider.add(SignInFormEvent.registerWithEmailAndPasswordPressed());
                }, child: Text("Register"),),
              ),
                ],
              ),
              ElevatedButton(onPressed: () {
                provider.add(SignInFormEvent.signInWithGooglePressed());
              }, child: Text("Sign In With Google"),),

              if (state.isSubmitting) ...[
                SizedBox(height: 10),
                LinearProgressIndicator(value: null,)
              ]
            ],
          ),
        );
      },
    );
  }
}
