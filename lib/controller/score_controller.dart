// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ScoreUpdate extends GetxController {
//   int score = 0;
//   @override
//   void onInit() {
//     init();
//     super.onInit();
//   }

//   SharedPreferences? pref;
//   Future init() async {
//     pref = await SharedPreferences.getInstance();
//   }

//   setter(int value) {
//     pref!.setInt("score", value);
//     score = pref?.getInt("score") ?? 0;
//   }

//   getter() {
//     score = pref?.getInt("score") ?? 0;
//   }

//   int val() {
//     return score;
//   }
// }
