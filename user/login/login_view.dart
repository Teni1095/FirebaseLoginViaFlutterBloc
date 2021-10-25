import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_bloc.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String _email = "", _password = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.indigo])),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(
              size: 150.0,
            ),
            TextField(
              decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Email",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: TextStyle(fontSize: 12.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)))),
              onChanged: (value) => _email = value,
            ),
            TextField(
              decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Password",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: TextStyle(fontSize: 12.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)))),
              obscureText: true,
              onChanged: (value) => _password = value,
            ),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  width: 200.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.resolveWith(
                            (states) => const StadiumBorder())),
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                          AuthenticateSignUpUsingEmailAndPassword(
                              _email.trim(), _password));
                    },
                    child: const Text("Create Account"),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                          AuthenticateSignInUsingEmailAndPassword(
                              _email.trim(), _password));
                    },
                    child: const Text(
                      "Already have an account? Sign in",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            const Text(
              "OR",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 200.0,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.deepOrange),
                    shape: MaterialStateProperty.resolveWith(
                        (states) => const StadiumBorder())),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(AuthenticateUsingGmail());
                },
                child: const Text("Sign up using Google"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
