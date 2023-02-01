import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';


class ZoomControl extends GetxController {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  Future<void> toggleDrawer() async {
    zoomDrawerController.toggle?.call();
    update();
  }


}

