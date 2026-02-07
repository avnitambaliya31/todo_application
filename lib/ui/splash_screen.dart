import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_application/app_routers/navigator_const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Size size;


  @override
  void initState() {
    super.initState();
    initDataCall();
  }

  initDataCall() {
    Timer(const Duration(seconds: 6), () {

      Navigator.pushNamedAndRemoveUntil(
        context,
        NavigatorConst.splashScreen,

            (Route<dynamic> route) => false,
      );

    });
  }


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Center(
          // child:
          // Image.asset(
          //   ImageConst.logo,
          //   width: size.width,
          //   height: size.height * 0.40,
          //   fit: BoxFit.cover,
          // ),
          // child: Image.asset(ImageConst.splashScreenGIF, width: size.width * 0.80),
        ),
      ),
    );
  }

}
