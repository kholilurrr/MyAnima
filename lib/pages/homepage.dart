import 'package:anilist_gql/pages/drawer.dart';
import 'package:anilist_gql/pages/login.dart';
import 'package:anilist_gql/pages/profile.dart';
import 'package:anilist_gql/utils/queries.dart';
import 'package:anilist_gql/widgets/resultslist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (c) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print(auth.currentUser!.email);
    }

    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE4EAF1),
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: 'My Anima'.text.color(Colors.white).letterSpacing(1.5).make(),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Container(
        height: Get.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimeList(
                mainTitle: 'Trending Now',
                query: trendingAnimeQuery,
                variables: 'trending',
              ),
              AnimeList(
                  mainTitle: 'Popular this Season',
                  query: popularAnimeQuery,
                  variables: 'popular'),
              AnimeList(
                mainTitle: 'Upcoming next Season',
                query: upcommingNextSeasonquery,
                variables: 'upcoming',
              ),
              AnimeList(
                mainTitle: 'All time popular',
                query: allTimePopularQuery,
                variables: 'alltime',
              ),
              AnimeList(
                mainTitle: 'Top 100 Anime',
                query: top100AnimeQuery,
                variables: 'top100',
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.amber[800],
      //   onTap: _onItemTapped,
      // ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              },
              icon: const Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
