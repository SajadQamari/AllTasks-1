import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:redo/views/components/configs.dart';
import 'package:redo/views/home_page.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      pageBackgroundGradient: LinearGradient(colors:[ColorPallet.subPrimary, ColorPallet.white],end: Alignment.bottomCenter,begin: Alignment.topCenter),
      headerBackgroundColor: ColorPallet.subPrimary,
      finishButtonColor: ColorPallet.secendary,
      hasFloatingButton: true,
      
      finishButtonText: "let's Rock",
      skipTextButton: Text('Skip'),
      //trailing: Text(''),

      background: [
        Image.asset('assets/images/success.png'),
        Image.asset('assets/images/target.png'),
        Image.asset('assets/images/Checklist.png'),
      ],
      totalPage: 3,
      speed: 1,
      pageBodies: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text('Challenge Yourself',style: AppTextStyle.titleCartView,),
              SizedBox(
                height:60,
              ),
              Text("List of task with cool customization to make your plan Exactly what you want",style: AppTextStyle.datePickerSheet,textAlign: TextAlign.center,)
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text('Analyse Progress',style: AppTextStyle.titleCartView,),
              SizedBox(
                height:60,
              ),
              Text("Compare your productivity with your Last month with coins that you achive after Compelet an activity!",style: AppTextStyle.datePickerSheet,textAlign: TextAlign.center,)
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text('Check it daily',style: AppTextStyle.titleCartView,),
              SizedBox(
                height:60,
              ),
              Text("List of task with cool customization to make your plan Exactly what you want",style: AppTextStyle.datePickerSheet,textAlign: TextAlign.center,)
            ],
          ),
        ),
      ],
      onFinish: () => Get.off(Homepage()),
    );
  }
}
