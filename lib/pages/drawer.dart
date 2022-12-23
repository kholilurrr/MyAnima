import 'package:anilist_gql/pages/homepage.dart';
import 'package:anilist_gql/pages/login.dart';
import 'package:anilist_gql/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(),
          _drawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                Navigator.pop(context);
              }),
          // _drawerItem(
          //     icon: Icons.chat,
          //     text: 'Chat',
          //     onTap: () => print('Tap Shared menu')),
          _drawerItem(
              icon: Icons.people,
              text: 'Profile',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              }),
          // _drawerItem(
          //     icon: Icons.settings,
          //     text: 'Setting',
          //     onTap: () => print('Tap Trash menu')),
          Divider(height: 25, thickness: 1),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
          //   child: Text("Labels",
          //       style: TextStyle(
          //         fontSize: 16,
          //         color: Colors.black54,
          //       )),
          // ),
          _drawerItem(
            icon: Icons.exit_to_app,
            text: 'Exit',
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (c) => LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}

Widget _drawerHeader() {
  return Container(
    decoration: BoxDecoration(color: Colors.blue),
    height: 200,
    child: Center(
        child: Text(
      'Hai Wibuuuu',
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 42, color: Colors.white),
    )),
  );
}

Widget _drawerItem({
  required IconData icon,
  required String text,
  required GestureTapCallback onTap,
}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}
