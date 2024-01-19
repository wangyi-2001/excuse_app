import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:excuse_demo/views/event/event.dart';
import 'package:excuse_demo/views/initial/change_pwd.dart';
import 'package:excuse_demo/views/initial/login.dart';
import 'package:excuse_demo/views/initial/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  if (Platform.isAndroid) {
    var style = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        'login':(context)=>const LoginPage(),
        'register':(context)=>const RegisterPage(),
        'changePwd':(context)=>const ChangePwdPage(),
        'event':(context)=>const EventPage()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? sharedPreferences;

  @override
  void initState(){
    super.initState();
    readFromStorage();
  }

  void readFromStorage() async {
    var prefs = await SharedPreferences.getInstance();
    var userJson = prefs.getString('user');
    if (userJson == null || userJson.isEmpty) {
      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPage()));
        });
      });
    } else {
      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const EventPage()));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlutterLogo(
            size: 100.0,
          ),
        ],
      )),
    );
  }
}
