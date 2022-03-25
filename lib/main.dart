import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/pages/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movieapp/pages/signin_page.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isLogin = false;
    if(FirebaseAuth.instance.currentUser != null) {
      isLogin = true;
    }
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
          primarySwatch: Colors.blue
        ),
      home: isLogin ? MainPage() : SigninPage(),
    );
  }
}
