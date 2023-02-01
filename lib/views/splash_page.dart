import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:redo/views/components/configs.dart';
import 'package:redo/views/home_page.dart';
import 'package:redo/views/onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatorScreen();
  }
  _navigatorScreen() async {
    bool firstRun = await IsFirstRun.isFirstRun();
    if (firstRun) {
      Future.delayed(Duration(seconds: 2), (() {
        Get.off(OnBoarding());
      }));
    } else {
      Future.delayed(Duration(seconds: 2), (() {
        Get.off(Homepage());
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorPallet.subPrimary, ColorPallet.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height / 6,
              left: MediaQuery.of(context).size.width / 11,
              child: const Center(
                child:
                    Image(image: AssetImage("assets/images/allTaskLogo.png")),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 8,
              left: MediaQuery.of(context).size.width / 2.5,
              child: const Center(
                child: SpinKitWave(
                  color: ColorPallet.secendary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
