import 'package:anilist_gql/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (c) => LoginScreen()));
          },
          child: Text(
            'Sign Out',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
