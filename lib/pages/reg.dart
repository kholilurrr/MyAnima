import 'dart:ffi';

import 'package:anilist_gql/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (c) => LoginScreen()));
  }

  // loginSumbimt() async {
  //   try {
  //     _firebaseAuth
  //         .signInWithEmailAndPassword(
  //             email: _emailController.text, password: _passwordController.text)
  //         .then((value) => Navigator.of(context).pushReplacement(
  //             MaterialPageRoute(builder: (context) => HomeScreen())));
  //   } catch (e) {
  //     print(e);
  //     SnackBar(
  //       content: Text(e.toString()),
  //     );
  //   }
  // }
  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
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
                "Register",
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
                    labelText: "Username"),
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
            // Container(
            //   height: 50,
            //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            //   child: ElevatedButton(
            //     style: raisedButtonStyle,
            //     child: Text("Login"),
            //     onPressed: () {
            //       loginSumbimt();
            //     },
            //   ),
            // // ),
            // SizedBox(
            //   height: 10,
            // ),
            Container(
              height: 55,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 40, right: 40),
              child: ElevatedButton(
                style: raisedButtonStyle,
                child: Text("Register"),
                onPressed: () {
                  registerSubmit();
                },
              ),
            ),
            TextButton(
              child: Text("Mempunyai akun? Sign In"),
              onPressed: (() => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (c) => LoginScreen()))),
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
