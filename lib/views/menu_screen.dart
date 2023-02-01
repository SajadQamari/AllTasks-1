import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redo/services/url_service.dart';
import 'package:redo/views/components/configs.dart';
import 'package:redo/views/developer_info_page.dart';
import 'package:redo/views/setting_page.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(color: ColorPallet.subPrimary),
      child: SafeArea(
          child: Column(
        children: [
          Image(image: AssetImage("assets/images/allTaskLogo.png")),
          _bottomIcon("settingLogo", "Setting", 0),
          _bottomIcon("githubLogo", "AllTask on GitHub", 1),
          _bottomIcon("email", "Developer info", 2),
        ],
      )),
    );
  }

  _bottomIcon(String icon, String label, int num) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        focusColor: ColorPallet.secendary,
        onTap: () {
          switch (num) {
            case 0:
              Get.off(SettingPage());
              break;

            case 1:
              luncher("https://github.com/EddyHezarian/AllTasks");
              break;
              
            case 2: Get.off(DevInfo());break
              ;
          }
        },
        child: Row(
          children: [
            ImageIcon(
              Image.asset("assets/icons/${icon}.png").image,
              size: 50,
            ),
            Text(
              label,
              style: AppTextStyle.cartTitle,
            ),
          ],
        ),
      ),
    );
  }
}
