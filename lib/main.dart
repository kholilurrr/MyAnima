import 'package:anilist_gql/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'pages/homepage.dart';

Future<void> main() async {
  await initHiveForFlutter();
  final HttpLink httpLink = HttpLink('https://graphql.anilist.co');
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyAppa(
    myclient: client,
  ));
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }// ignore: must_be_immutable
class MyAppa extends StatelessWidget {
  MyAppa({Key? key, required this.myclient}) : super(key: key);
  ValueNotifier<GraphQLClient> myclient;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));
    return GraphQLProvider(
      client: myclient,
      child: const CacheProvider(
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false, home: LoginScreen()),
      ),
    );
  }
}
