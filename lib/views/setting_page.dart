import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redo/views/components/configs.dart';
import 'package:redo/views/home_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //! back button
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 10, bottom: 30),
                child: IconButton(
                    onPressed: (() => Get.to(Homepage())),
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: ColorPallet.black,
                      size: 40,
                    )),
              ),
            ),
            //! picture
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/develop.png"),
                      fit: BoxFit.fill)),
            ),
            //! icon and text
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_rounded,
                    color: ColorPallet.yellow,
                    size: 50,
                  ),
                  Container(
                      width: 250,
                      child: Text(
                        "Sorry ; Your not able to set options in this version",
                        style: AppTextStyle.cartTitle,
                      )),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(50),
              child: InkWell(
                onTap: () {
                  Get.off(Homepage());
                },
                child: Container(
                  width: 150,
                  height: 70,
                  decoration: BoxDecoration(
                      //border: Border.all(color: ColorPallet.secendary),
                      borderRadius: BorderRadius.circular(25),
                      color: ColorPallet.primary,
                      boxShadow: const <BoxShadow>[
                        BoxShadow(blurRadius: 2, blurStyle: BlurStyle.outer)
                      ]),
                  child: Center(
                      child: Text(
                    "Back to Home",
                    style: AppTextStyle.doneBottom,
                  )),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
