import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/provider.dart';
import 'package:todo/screens/home/home.dart';
import 'package:todo/screens/update_screen.dart';
import 'package:todo/utils/my_them_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await FirebaseFirestore.instance.disableNetwork();

  runApp(ChangeNotifierProvider(
    create: (_)=>ListProvider(),
      child: MyApp()));
}
class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: MyThemData.light,
      darkTheme: MyThemData.darkTheme,
      themeMode: ThemeMode.system,
     supportedLocales: const[
       Locale('ar'),
       Locale('en')
     ],
     locale: Locale("en"),
     routes: {
        Home.routeName:(_)=>Home(),
       UpdateScreen.routeName:(_)=>UpdateScreen()
     },
      initialRoute: Home.routeName,
    );
  }
}
