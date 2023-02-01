import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redo/services/url_service.dart';
import 'package:redo/views/components/configs.dart';
import 'package:redo/views/home_page.dart';

class DevInfo extends StatelessWidget {
  const DevInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.38,
                  decoration: BoxDecoration(
                      color: ColorPallet.primary,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(120),
                          bottomRight: Radius.circular(120))),
                ),
                //! back button
                IconButton(
                  onPressed: () => Get.to(Homepage()),
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    size: 40,
                  ),
                ),
                //! picture
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.31,
                  top: MediaQuery.of(context).size.height * 0.10,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        color: ColorPallet.catHealth,
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: AssetImage("assets/images/eddy.jpg"),
                            fit: BoxFit.cover)),
                  ),
                ),
                //! name
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.30,
                    left: MediaQuery.of(context).size.width * 0.334,
                    //right: MediaQuery.of(context).size.width*0.5 ,
                    child: Text(
                      "Eddy Hezarian",
                      style: AppTextStyle.cartTitle,
                    ))
              ],
            ),
            //! reach me 
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 15),
              child: Text(
                "How to Reach Me :",
                style: AppTextStyle.cartTitle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //* git hub
                InkWell(
                    onTap: () => luncher("https://github.com/EddyHezarian"),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/githubLogo.png"),
                              fit: BoxFit.fill)),
                    )),
                //*linkedin
                InkWell(
                    onTap: () => luncher("https://www.linkedin.com/in/eddy-hezarian-miow/"),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/linkedin.png"),
                              fit: BoxFit.fill)),
                    )),
                //*email
                InkWell(
                    onTap: () => sendEmail("eddyhzn@gmail.com"),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/email.png"),
                              fit: BoxFit.fill)),
                    )),
              ],
            ),
            //! skills
            //* text
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 50),
              child: Text(
                "Skills :",
                style: AppTextStyle.cartTitle,
              ),
            ),
            //* flutter
            Padding(
              padding: const EdgeInsets.only(top: 15,left: 40),
              child: Column(
                children: [
                  Row(children: [
                    Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/icons/flutter.png"),
                                fit: BoxFit.fill)),
                      ),
                    SizedBox(width: 20,),
                    Text("Flutter developer",style: AppTextStyle.categorySheet,)
                  ],),
                  


                ],
              ),
            ),
            //*word press
            Padding(
              padding: const EdgeInsets.only(top: 15,left: 40),
              child: Column(
                children: [
                  Row(children: [
                    Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/icons/wp.png"),
                                fit: BoxFit.fill)),
                      ),
                    SizedBox(width: 20,),
                    Text("word Press Web designer",style: AppTextStyle.categorySheet,)
                  ],),],),
                ),
            //* figma
            Padding(
              padding: const EdgeInsets.only(top: 15,left: 40),
              child: Column(
                children: [
                  Row(children: [
                    Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/icons/figma.png"),
                                fit: BoxFit.fill)),
                      ),
                    SizedBox(width: 20,),
                    Text("UI UX designer",style: AppTextStyle.categorySheet,)
                  ],),],),
            ),
          ],
        ),
      ),
    );
  }
}
