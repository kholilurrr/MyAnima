import 'dart:ffi';

import 'package:anilist_gql/pages/homepage.dart';
import 'package:anilist_gql/pages/reg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  registerSubmit() async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text.toString().trim(),
          password: _passwordController.text);
    } catch (e) {
      print(e);
      SnackBar(
        content: Text(e.toString()),
      );
    }
  }

  loginSumbimt() async {
    try {
      _firebaseAuth
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage())));
    } catch (e) {
      print(e);
      SnackBar(
        content: Text(e.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 200),
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 40, bottom: 10, left: 40, right: 40),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  labelText: "email@address",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: 10,
                left: 40,
                right: 40,
              ),
              child: TextField(
                obscureText: _isHidePassword,
                autofocus: false,
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  labelText: "Password",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _togglePasswordVisibility();
                    },
                    child: Icon(
                      _isHidePassword ? Icons.visibility_off : Icons.visibility,
                      color: _isHidePassword ? Colors.grey : Colors.blue,
                    ),
                  ),
                  // isDense: true,
                ),
              ),
            ),
            Container(
              height: 55,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 40, right: 40),
              child: ElevatedButton(
                style: raisedButtonStyle,
                child: Text("Login"),
                onPressed: () {
                  loginSumbimt();
                },
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   height: 50,
            //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            //   child: ElevatedButton(
            //     style: raisedButtonStyle,
            //     child: Text("Register"),
            //     onPressed: () {
            //       registerSubmit();
            //     },
            //   ),
            // ),
            TextButton(
              child: Text(
                "Tidak Mempunyai akun? Sign Up",
              ),
              onPressed: (() => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (c) => RegScreen()))),
            ),
          ],
        ),
      ),
    );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Colors.blue,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))));
}
