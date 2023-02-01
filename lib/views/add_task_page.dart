import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:redo/controller/task_controller.dart';
import 'package:redo/model/task_model.dart';
import 'package:redo/views/components/configs.dart';
import 'package:redo/views/home_page.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

//!controllers
  final TaskController _controller = Get.put(TaskController());
  var _selectedDate = DateTime.now();
  final TextEditingController _titleControl = TextEditingController();
  final TextEditingController _noteControl = TextEditingController();
  String _selectedPriorty = "low";
  String _selectedCategoy = "task";
  DateTime _selectedTime = DateTime.now();
  String _selectedRepeat = "once";
  
//? build method
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPallet.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              //! back bottom
              _appBar(),
              //!title form
              CustomFormView(
                title: "Title",
                hint: "",
                control: _titleControl,
              ),
              //! describtion
              CustomFormView(title: "Note", hint: "", control: _noteControl),
              //! priorty and category
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                //* category
                CustomeContainer(
                  title: "Category",
                  icon: _catagoryicon(_selectedCategoy),
                  isBigContainer: true,
                  color: _catagoryBackColor(_selectedCategoy),
                  selected: _selectedCategoy,
                  action: InkWell(
                      onTap: () {
                        _categoryBottomSheet(context);
                      },
                      child: const Icon(Icons.keyboard_arrow_down)),
                ),

                //* priorty
                CustomeContainer(
                  action: InkWell(
                    onTap: () {
                      _priortyBottomSheet(context);
                    },
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                  title: "Priorty",
                  selected: _selectedPriorty,
                  icon: _priordyicon(_selectedPriorty),
                  isBigContainer: true,
                  
                  color: _priordyBackColor(_selectedPriorty),
                ),
              ]),
              //! time and date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                //* time
                CustomeContainer(
                    action: InkWell(
                      child: const Icon(Icons.keyboard_arrow_down),
                      onTap: () => _timePickerSheet(context),
                    ),
                    title: "Time",
                    selected:
                        DateFormat("hh:mm a").format(_selectedTime).toString(),
                    icon: AppIcons.timeTASK,
                    isBigContainer: false,
                    ),
                //* date
                CustomeContainer(
                    action: InkWell(
                      child: const Icon(Icons.keyboard_arrow_down),
                      onTap: () => _datePickerSheet(context),
                    ),
                    title: "Date",
                    selected: DateFormat.Md().format(_selectedDate),
                    icon: AppIcons.dateTASK,
                    isBigContainer: false,
                    ),
              ]),
              //! Repeat
              CustomeContainer(
                  action: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: (() => _repeatBottomSheet(context)),
                      child: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                  title: "Repeat",
                  selected: _selectedRepeat,
                  icon: AppIcons.repeatTASK,
                  isBigContainer: false,
                  ),
              //!  submit bottom
              Padding(
                padding: const EdgeInsets.all(30),
                child: InkWell(
                  onTap: () {
                    _validateData();
                  },
                  child: Container(
                    width: 120,
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
                      "Done",
                      style: AppTextStyle.doneBottom,
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  _appBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
            onPressed: () {
              Get.off(() => const Homepage());
            },
            icon: const Icon(
              Icons.keyboard_arrow_left,
              color: ColorPallet.black,
              size: 40,
            )),
      ),
    );
  }

//! bottomSheets for selecting item 
  _datePickerSheet(BuildContext context) async {
    DatePicker.showDatePicker(
      currentTime: DateTime.now(),
      locale: LocaleType.en,
      context,
      maxTime: DateTime(2100, 01, 01),
      minTime: DateTime(2023, 01, 01),
      theme: DatePickerTheme(
          headerColor: ColorPallet.secendary,
          backgroundColor: ColorPallet.white,
          itemStyle: AppTextStyle.datePickerSheet,
          doneStyle: AppTextStyle.datePickerSheetButton),
      onChanged: (time) {
        setState(() {
          _selectedDate = time;
        });
      },
    );
  }

  _categoryBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 247, 245, 245)),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategoy = "task";
                          Get.back();
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: ColorPallet.catTask,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: AppIcons.taskCAT,
                            ),
                          ),
                          Text(
                            "Task",
                            style: AppTextStyle.categorySheet,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategoy = "bad habbit";
                          Get.back();
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: ColorPallet.catQuit,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: AppIcons.quitCAT,
                            ),
                          ),
                          Text(
                            "Bad habbit",
                            style: AppTextStyle.categorySheet,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategoy = "study";
                          Get.back();
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: ColorPallet.catStudy,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: AppIcons.studyCAT,
                            ),
                          ),
                          Text(
                            "Study",
                            style: AppTextStyle.categorySheet,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategoy = "mentaly";
                          Get.back();
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: ColorPallet.catMeditation,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: AppIcons.meditationCAT,
                            ),
                          ),
                          Text(
                            "Mentaly",
                            style: AppTextStyle.categorySheet,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategoy = "sport";
                          Get.back();
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: ColorPallet.catSport,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: AppIcons.sportCAT,
                            ),
                          ),
                          Text(
                            "Sport",
                            style: AppTextStyle.categorySheet,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategoy = "home";
                          Get.back();
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: ColorPallet.catHome,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: AppIcons.homeCAT,
                            ),
                          ),
                          Text(
                            "Home",
                            style: AppTextStyle.categorySheet,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategoy = "health";
                          Get.back();
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: ColorPallet.catHealth,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: AppIcons.healthCAT,
                            ),
                          ),
                          Text(
                            "Health",
                            style: AppTextStyle.categorySheet,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategoy = "social";
                          Get.back();
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: ColorPallet.catSocial,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: AppIcons.socialCAT,
                            ),
                          ),
                          Text(
                            "Social",
                            style: AppTextStyle.categorySheet,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategoy = "work";
                          Get.back();
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: ColorPallet.catwork,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: AppIcons.workCAT,
                            ),
                          ),
                          Text(
                            "Work",
                            style: AppTextStyle.categorySheet,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: ColorPallet.white,
      elevation: 2,
    );
  }

  _timePickerSheet(BuildContext context) async {
    final result = await TimePicker.show<DateTime?>(
        context: context,
        sheet: TimePickerSheet(
          minuteInterval: 1,
          minuteTitleStyle: AppTextStyle.timePickerSheet,
          hourTitleStyle: AppTextStyle.timePickerSheet,
          wheelNumberSelectedStyle: AppTextStyle.timePickerSheet,
          sheetTitle: 'Select Time for event',
          minuteTitle: 'Minute',
          hourTitle: 'Hour',
          sheetCloseIconColor: ColorPallet.secendary,
          saveButtonText: 'Set',
          saveButtonColor: ColorPallet.primary,
        ));
    if (result != null) {
      setState(() {
        _selectedTime = result;
      });
    }
  }

  _priortyBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 247, 245, 245),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedPriorty = "low";
                      Get.back();
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: ColorPallet.lowPriordyBack,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: AppIcons.lowPriorty,
                        ),
                      ),
                      Text(
                        "Low",
                        style: AppTextStyle.categorySheet,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedPriorty = "medium";
                      Get.back();
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: ColorPallet.mediumePriordyBack,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: AppIcons.mediumePriorty,
                        ),
                      ),
                      Text(
                        "Medium",
                        style: AppTextStyle.categorySheet,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedPriorty = "high";
                      Get.back();
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: ColorPallet.highPriordyBack,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: AppIcons.highPriorty,
                        ),
                      ),
                      Text(
                        "High",
                        style: AppTextStyle.categorySheet,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: ColorPallet.white,
      elevation: 2,
      //persistent: false
    );
  }

  _repeatBottomSheet(BuildContext context) {
    Get.bottomSheet(Container(
      height: MediaQuery.of(context).size.height * 0.23,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 247, 245, 245),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.grey),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(children: [
                InkWell(
                    onTap: () => setState(() {
                          _selectedRepeat = "once";
                          Get.back();
                        }),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorPallet.subPrimary),
                      child: const Center(
                        child: Icon(
                          Icons.repeat_one,
                          size: 40,
                        ),
                      ),
                    )),
                Text(
                  "Once",
                  style: AppTextStyle.cartTitle,
                )
              ]),
              Column(children: [
                InkWell(
                    onTap: () => setState(() {
                          _selectedRepeat = "daily";
                          Get.back();
                        }),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorPallet.subPrimary),
                      child: const Center(
                        child: Icon(
                          Icons.repeat,
                          size: 40,
                          color: ColorPallet.secendary,
                        ),
                      ),
                    )),
                Text(
                  "Daily",
                  style: AppTextStyle.cartTitle,
                )
              ]),
              Column(children: [
                InkWell(
                    onTap: () => setState(() {
                          _selectedRepeat = "weekly";
                          Get.back();
                        }),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorPallet.subPrimary),
                      child: const Center(
                        child: Icon(
                          Icons.date_range_rounded,
                          size: 40,
                          color: ColorPallet.secendary,
                        ),
                      ),
                    )),
                Text(
                  "Weekly",
                  style: AppTextStyle.cartTitle,
                )
              ]),
            ],
          ),
        ],
      ),
    ));
  }

//! add task to db and validate data 

  _validateData() {

    if (_titleControl.text.isNotEmpty) {
      _addTaskToDB();
      print(DateFormat("hh:mm a").format(_selectedTime).toString());
      _controller.getTask();
      _successSnack();
      Get.to(() => const Homepage());
    } else if (_titleControl.text.isEmpty) {
      _warningSnack();
    }
  }

  _addTaskToDB() async {
    await _controller.addTask(
        task: TaskModel(
      title: _titleControl.text,
      note: _noteControl.text,
      time: DateFormat("hh:mm a").format(_selectedTime).toString(),
      repeat: _selectedRepeat,
      priorty: _selectedPriorty,
      category: _selectedCategoy,
      date: DateFormat.yMd().format(_selectedDate),
      isCompelet: 0,
    ));
  }

  void _warningSnack() {
    final snack = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        content: AwesomeSnackbarContent(
          title: "Requeir",
          message: "fill the Title and Note ",
          contentType: ContentType.warning,
        ));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snack);
  }

  void _successSnack() {
    final snack = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        content: AwesomeSnackbarContent(
          title: "well done",
          message: "just do this :)",
          contentType: ContentType.success,
        ));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snack);
  }

//!color and icon returner
  Color? _priordyBackColor(String num) {
    switch (num) {
      case "low":
        return Color.fromARGB(255, 141, 198, 255);
      case "medium":
        return ColorPallet.mediumePriordyicon;
      case "high":
        return ColorPallet.highPriordyicon;
    }
    return null;
  }

  dynamic _priordyicon(String num) {
    switch (num) {
      case "low":
        return AppIcons.lowPriorty;
      case "medium":
        return AppIcons.mediumePriorty;
      case "high":
        return AppIcons.highPriorty;
    }
  }

  dynamic _catagoryicon(String num) {
    switch (num) {
      case "task":
        return AppIcons.taskCAT;
      case "bad habbit":
        return AppIcons.quitCAT;
      case "study":
        return AppIcons.studyCAT;
      case "mentaly":
        return AppIcons.meditationCAT;
      case "sport":
        return AppIcons.sportCAT;
      case "home":
        return AppIcons.homeCAT;
      case "health":
        return AppIcons.healthCAT;
      case "social":
        return AppIcons.socialCAT;
      case "work":
        return AppIcons.workCAT;
    }
  }

  Color? _catagoryBackColor(String num) {
    switch (num) {
      case "task":
        return Color.fromARGB(255, 234, 234, 234);
      case "bad habbit":
        return ColorPallet.catQuit;
      case "study":
        return ColorPallet.catStudy;
      case "mentaly":
        return ColorPallet.catMeditation;
      case "sport":
        return ColorPallet.catSport;
      case "home":
        return ColorPallet.catHome;
      case "health":
        return ColorPallet.catHealth;
      case "social":
        return ColorPallet.catSocial;
      case "work":
        return ColorPallet.catwork;
    }
    return null;
  }
}

//! customized form feild for Title and note
class CustomFormView extends StatelessWidget { 
  final String? title;
  final String? hint;
  final TextEditingController? control;

  const CustomFormView({super.key, this.title, this.hint, this.control});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* title
        Padding(
            padding: const EdgeInsets.only(left: 60, top: 30, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title!,
                style: AppTextStyle.addTitle,
              ),
            )),
        //* box form
        Container(
            padding: const EdgeInsets.only(left: 20),
            width: 300,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: ColorPallet.lightgrey, width: 2)),
            child: Center(
              child: TextFormField(
                  controller: control!,
                  decoration: InputDecoration(
                      hintText: hint!,
                      border: InputBorder.none,
                      hintStyle: AppTextStyle.inputHint,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ))),
            ))
      ],
    );
  }
}

//! customized container for parameter selection (priorty,category,time,date,repeat)
class CustomeContainer extends StatelessWidget {
  
  final bool isBigContainer; //* if true : size will be biger and color will depends on selected inner item 
                             //* if false: size is smaller and color will be static
  final Widget? action; //* a button that show bottomSheet . 
  final String? title;    
  final String? selected; 
  final dynamic icon;  
  final dynamic color; 
  const CustomeContainer(
      {super.key,
      required this.action,
      required this.title,
      required this.selected,
      required this.icon,
      this.color,
      required this.isBigContainer,
    });
  @override
  Widget build(BuildContext context) {
    return 
        Container(
      //! decoration and alignment 
      margin: EdgeInsets.only(top: 20),
      width: isBigContainer ? 170 : 150,
      height: isBigContainer ? 80 : 60,
      decoration: BoxDecoration(
        color: isBigContainer ? color : ColorPallet.white,
        borderRadius: BorderRadius.circular(20),
        border: isBigContainer
            ? Border.all(color: ColorPallet.midGrey, width: 2)
            : Border.all(color: ColorPallet.secendary, width: 2),
      ),
      //! details 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        //? simbol
        isBigContainer
            ? Container(
                margin: const EdgeInsets.only(left: 5),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: ColorPallet.white),
                child: icon,
              )
            : Container(
                margin: const EdgeInsets.only(left: 5),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    color: ColorPallet.subPrimary),
                child: icon,
              ),
        //? texts
        Column(
          children: [
            Text(
              title!,
              style: AppTextStyle.cartTitle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                selected!,
                style: AppTextStyle.subcartTitle,
              ),
            )
          ],
        ),
        //? bottomshet button
        Container(
          child: action,
        )
      ]),
    );
  }
}
