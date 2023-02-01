import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorPallet {
  //* main colors
  static const Color primary = Color.fromARGB(255, 85, 186, 185);
  static const Color subPrimary = Color.fromARGB(255, 120, 229, 227);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color grey = Color.fromARGB(255, 157, 157, 157);
  static const Color midGrey = Color.fromARGB(255, 223, 223, 223);
  static const Color lightgrey = Color.fromARGB(199, 229, 229, 229);
  static const Color secendary = Color.fromARGB(255, 61, 162, 150);
  static const Color taskCart = Color.fromARGB(255, 235, 247, 255);
  static const Color yellow = Color.fromARGB(255, 255, 208, 0);
  static const Color backgroundMainCarts = Color.fromARGB(255, 203, 233, 233);

  //*  catagory background colors
  static Color? catTask = Colors.grey[350];
  static Color? catQuit = const Color.fromARGB(244, 255, 224, 178);
  static Color? catMeditation = const Color.fromARGB(242, 225, 190, 231);
  static Color? catSport = const Color.fromARGB(242, 187, 222, 251);
  static Color? catHome = const Color.fromARGB(242, 132, 255, 255);
  static Color? catStudy = const Color.fromARGB(240, 248, 187, 208);
  static Color? catHealth = const Color.fromARGB(224, 185, 246, 202);
  static Color? catSocial = const Color.fromARGB(208, 155, 223, 217);
  static Color? catwork = const Color.fromARGB(241, 255, 139, 128);

  //* catagory icon colors
  static Color? icoTask = const Color.fromARGB(255, 0, 0, 0);
  static Color? icoQuit = const Color.fromARGB(255, 255, 132, 0);
  static Color? icoMeditation = const Color.fromARGB(255, 217, 0, 255);
  static Color? icoSport = const Color.fromARGB(255, 0, 8, 255);
  static Color? icoHome = const Color.fromARGB(255, 0, 190, 190);
  static Color? icoStudy = const Color.fromARGB(255, 255, 21, 103);
  static Color? icoHealth = const Color.fromARGB(255, 4, 200, 59);
  static Color? icoSocial = const Color.fromARGB(255, 0, 222, 159);
  static Color? icowork = const Color.fromARGB(255, 255, 0, 0);

  //* priordy background
  static Color? lowPriordyBack = const Color.fromARGB(255, 201, 219, 246);
  static Color? mediumePriordyBack = const Color.fromARGB(255, 255, 198, 135);
  static Color? highPriordyBack = const Color.fromARGB(255, 255, 173, 173);

  //* priordy Icon
  static Color? lowPriordyicon = const Color.fromARGB(255, 0, 102, 255);
  static Color? mediumePriordyicon = const Color.fromARGB(255, 255, 136, 0);
  static Color? highPriordyicon = const Color.fromARGB(255, 255, 0, 0);
}

class AppIcons {
  //! priorty part
  static dynamic highPriorty = Icon(
    CupertinoIcons.flame,
    color: ColorPallet.highPriordyicon,
  );
  static dynamic lowPriorty = Icon(
    CupertinoIcons.thermometer_snowflake,
    color: ColorPallet.lowPriordyicon,
  );
  static dynamic mediumePriorty = Icon(
    CupertinoIcons.hand_thumbsup_fill,
    color: ColorPallet.highPriordyicon,
  );

  //! category part
  static dynamic taskCAT = Icon(
    CupertinoIcons.check_mark_circled,
    color: ColorPallet.icoTask,
    size: 40,
  );
  static dynamic quitCAT = Icon(
    CupertinoIcons.nosign,
    color: ColorPallet.icoQuit,
    size: 40,
  );
  static dynamic studyCAT = Icon(
    Icons.school,
    color: ColorPallet.icoStudy,
    size: 40,
  );
  static dynamic meditationCAT = Icon(
    Icons.self_improvement,
    color: ColorPallet.icoMeditation,
    size: 40,
  );
  static dynamic sportCAT = Icon(
    Icons.fitness_center_outlined,
    color: ColorPallet.icoSport,
    size: 40,
  );
  static dynamic homeCAT = Icon(
    CupertinoIcons.home,
    color: ColorPallet.icoHome,
    size: 40,
  );
  static dynamic healthCAT = Icon(
    Icons.health_and_safety,
    color: ColorPallet.icoHealth,
    size: 40,
  );
  static dynamic socialCAT = Icon(
    CupertinoIcons.chat_bubble_2,
    color: ColorPallet.icoSocial,
    size: 40,
  );
  static dynamic workCAT = Icon(
    CupertinoIcons.briefcase_fill,
    color: ColorPallet.icowork,
    size: 40,
  );

  //! navigation part
  static dynamic todayNav = const Icon(
    Icons.calendar_today_outlined,
    color: ColorPallet.white,
  );
  static dynamic todayNavClicked = const Icon(
    Icons.calendar_today_outlined,
    color: ColorPallet.black,
  );
  static dynamic taskNav = const Icon(
    Icons.task,
    color: ColorPallet.white,
  );
  static dynamic taskNavClicked = const Icon(
    Icons.task,
    color: ColorPallet.black,
  );
  static dynamic addNav = const Icon(
    CupertinoIcons.plus,
    color: ColorPallet.white,
  );
  static dynamic challengeNav = const Icon(
    CupertinoIcons.scope,
    color: ColorPallet.white,
  );
  static dynamic challengeNavClicked = const Icon(
    CupertinoIcons.scope,
    color: ColorPallet.black,
  );
  static dynamic analyzeNav = const Icon(
    Icons.insert_chart_outlined_rounded,
    color: ColorPallet.white,
  );
  static dynamic analyzeNavClicked = const Icon(
    Icons.insert_chart_outlined_rounded,
    color: ColorPallet.black,
  );

  //! recurring
  static dynamic onceREP = const Icon(
    Icons.repeat_one,
    color: ColorPallet.grey,
  );
  static dynamic dailyREP = const Icon(
    Icons.repeat,
    color: ColorPallet.grey,
  );
  static dynamic weeklyREP = const Icon(
    Icons.event_repeat_outlined,
    color: ColorPallet.grey,
  );
  static dynamic monthREP = const Icon(
    Icons.sunny,
    color: ColorPallet.grey,
  );

  //! add task part
  static dynamic timeTASK = const Icon(
    CupertinoIcons.clock,
    color: ColorPallet.secendary,
  );
  static dynamic dateTASK = const Icon(
    CupertinoIcons.calendar,
    color: ColorPallet.secendary,
  );
  static dynamic personTASK = const Icon(
    CupertinoIcons.person_fill,
    color: ColorPallet.secendary,
  );
  static dynamic repeatTASK = const Icon(
    Icons.repeat,
    color: ColorPallet.secendary,
  );

  //! main icon part
  static dynamic edit = const Icon(
    Icons.edit,
    color: ColorPallet.grey,
  );
  static dynamic star = const Icon(
    Icons.star,
    color: ColorPallet.yellow,
  );
  static dynamic menu = const Icon(
    Icons.menu_outlined,
    color: ColorPallet.primary,
  );
  static dynamic timeTaskCart = const Icon(
    CupertinoIcons.clock,
    color: Color.fromARGB(255, 0, 0, 0),
  );
}

class AppTextStyle {
  static TextStyle appBar = GoogleFonts.inter(
    color: ColorPallet.black,
    fontSize: 23,
    fontWeight: FontWeight.bold,
  );
  static TextStyle welcome = GoogleFonts.inter(
    color: ColorPallet.grey,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle timeLine0 = GoogleFonts.inter(
    color: ColorPallet.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle timeLine1 = GoogleFonts.inter(
    color: ColorPallet.white,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  static TextStyle listTitle = GoogleFonts.inter(
    color: ColorPallet.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle seeAll = GoogleFonts.inter(
    color: ColorPallet.primary,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static TextStyle addTitle = GoogleFonts.inter(
    color: ColorPallet.grey,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static TextStyle cartTitle = GoogleFonts.inter(
    color: const Color.fromARGB(255, 0, 0, 0),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static TextStyle categorySheet = GoogleFonts.inter(
    color: const Color.fromARGB(255, 0, 0, 0),
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle subcartTitle = GoogleFonts.inter(
    color: const Color.fromARGB(255, 0, 0, 0),
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );
  static TextStyle doneBottom = GoogleFonts.inter(
    color: ColorPallet.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle timeCartView = GoogleFonts.inter(
    color: ColorPallet.black,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static TextStyle titleCartView = GoogleFonts.inter(
    color: ColorPallet.black,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static TextStyle inputHint = GoogleFonts.inter(
    color: ColorPallet.grey,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle timePickerSheet = GoogleFonts.lato(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: const Color.fromARGB(255, 82, 158, 184));
  static TextStyle datePickerSheet = GoogleFonts.lato(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color:ColorPallet.black);
  static TextStyle datePickerSheetButton = GoogleFonts.lato(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: ColorPallet.white);
}
