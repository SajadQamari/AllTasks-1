import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:redo/controller/task_controller.dart';
import 'package:redo/model/task_model.dart';
import 'package:redo/views/add_task_page.dart';
import 'package:redo/views/components/configs.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final TaskController _taskController = Get.put(TaskController());

  var userDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var dayinit = DateTime.now().day;
    var monthinit = DateTime.now().month;
    var yearinit = DateTime.now().year;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPallet.white,
        body: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            _appBar(),
            _pickerTime(yearinit, monthinit, dayinit),
            _cartList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorPallet.primary,
          child: AppIcons.addNav,
          onPressed: () => Get.off(const AddTask()),
        ),
      ),
    );
  }

  _appBar() {
    return Row(
      //*sideBar bottom
      children: [
        IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            size: 40,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        //*text
        Text(
          "Tasks",
          style: AppTextStyle.appBar,
        ),
      ],
    );
  }

  _pickerTime(int yearinit, int monthinit, int dayinit) {
    return FlutterDatePickerTimeline(
      initialSelectedDate: DateTime(yearinit, monthinit, dayinit),
      initialFocusedDate: DateTime(yearinit, monthinit, dayinit),
      startDate: DateTime(2023),
      endDate: DateTime(2200),
      itemHeight: 70,
      itemRadius: 20,
      listViewPadding: const EdgeInsets.all(10),
      selectedItemBackgroundColor: ColorPallet.primary,
      selectedItemWidth: 150,
      selectedItemTextStyle: AppTextStyle.timeLine1,
      unselectedItemBackgroundColor: ColorPallet.lightgrey,
      unselectedItemWidth: 50,
      unselectedItemTextStyle: AppTextStyle.timeLine0,
      onSelectedDateChange: (DateTime? dateTime) {
        setState(() {
          userDate = dateTime!;
        });
      },
    );
  }

  _cartList() {
    return Expanded(child: Obx(
      () {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: ((_, index) {
              var cart = _taskController.taskList[index];
              return Container(
                child: AnimationConfiguration.staggeredGrid(
                  duration: Duration(milliseconds: 400),
                  columnCount: 1,
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                        child:
                            //!daily
                            cart.repeat == 'daily'
                                ? cart.isCompelet == 1
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            right: 30, left: 30),
                                        child: FullTaskcart(
                                          model: cart,
                                        ),
                                      )
                                    : FullTaskcart(model: cart)
                                :
                                //!weekly
                                cart.repeat == 'weekly'
                                    ? _weekChecker(userDate, cart.date!) == true
                                        ? cart.isCompelet == 1
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 30, left: 30),
                                                child: FullTaskcart(
                                                  model: cart,
                                                ),
                                              )
                                            : FullTaskcart(model: cart)
                                        : Container()
                                    :
                                    //!once
                                    cart.date ==
                                            DateFormat.yMd().format(userDate)
                                        ? cart.isCompelet == 1
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 30, left: 30),
                                                child: FullTaskcart(
                                                  model: cart,
                                                ),
                                              )
                                            : FullTaskcart(model: cart)
                                        : Container()),
                  ),
                ),
              );
            }));
      },
    ));
  }

  bool _weekChecker(DateTime pickedDate, String modelDate) {
//! as model.date date format is dd/mm/yyyy  we cant get direct access of weekday of model date  .
//! this function will check 2 dates and compare them . if they were in same weekday returns true

    int j = 0, i = 0;//* i , j are counter 

    int day = 0, month = 0;

//* string proccing for day and month of model date 
    for (; modelDate[i] != '/'; i++) {
      month += int.parse(modelDate[i]);
      month * 10;
    }
    month = month % 10;
    i++;
    for (; modelDate[i] != '/'; i++) {
      j == 0
          ? day += int.parse(modelDate[i]) * 10
          : day += int.parse(modelDate[i]);
      j++;
    }
    if (month == pickedDate.month) { 
      if ((day - pickedDate.day) % 7 == 0) { //* formula of being on same weekday if months are same 
        return true;
      } else {
        return false;
      }
    } else if (month == 1 || 
        month == 3 ||
        month == 5 ||
        month == 7 ||
        month == 8 ||
        month == 10 ||
        month == 12) {
      if ((day - pickedDate.day) % 7 == 3) { //* formula of being on same weekday if model month is in this numbers 
        return true;
      } else {
        return false;
      }
    } else if (month == 2) {
      if ((day - pickedDate.day) % 7 == 0) { //* formula of being on same weekday if model month is 2
        return true;
      } else {
        return false;
      }
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
      if ((day - pickedDate.day) % 7 == 2) {  //* formula of being on same weekday if model month is in this numbers 
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

// ignore: must_be_immutable
class FullTaskcart extends StatelessWidget {
  TaskModel model;
  FullTaskcart({super.key, required this.model});

  final TaskController _controller = Get.put(TaskController());
  var userDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        _deletBottomSheet(context, model);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        margin: const EdgeInsets.all(20),
        height: 160,
        decoration: BoxDecoration(
          color: ColorPallet.backgroundMainCarts,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //! information
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* iconic items (catgory , title , priorty)
                Row(
                  children: [
                    //* category
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: _catagoryBackColor(model.category!),
                        border: Border.all(
                            color: _catagoryIconColor(model.category!)!),
                      ),
                      child: _catagoryicon(model.category!),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    //* infos
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //* title
                          SizedBox(
                            width: 100,
                            height: 60,
                            child: Text(
                              model.title!,
                              style: AppTextStyle.titleCartView,
                            ),
                          ),

                          //* icons
                          Row(
                            children: [
                              _priordyicon(model.priorty!),
                              _repeatyicon(model.repeat!),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                //* description
                SizedBox(width: 180, height: 50, child: Text(model.note!))
              ],
            ),

            //! time and check box
            Column(
              children: [
                //* time
                Row(
                  children: [
                    //*time icon
                    AppIcons.timeTASK,
                    //* time string
                    Text(
                      model.time!,
                      style: AppTextStyle.timeCartView,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //* check box
                InkWell(
                  onTap: () {
                  model.isCompelet == 0
                        ? _controller.markAsCompelet(model.id!)
                        : _controller.undoCompelet(model.id!);
                  },
                  child: Container(
                    width: model.isCompelet == 1 ? 30 : 50,
                    height: model.isCompelet == 1 ? 30 : 50,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: ColorPallet.subPrimary, width: 2),
                        borderRadius: model.isCompelet == 1
                            ? BorderRadius.circular(10)
                            : BorderRadius.circular(20),
                        color: ColorPallet.white),
                    child: model.isCompelet == 1
                        ? const Center(
                            child: Icon(Icons.done),
                          )
                        : Container(),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

//! color and icon functions
  dynamic _repeatyicon(String num) {
    switch (num) {
      case "once":
        return AppIcons.onceREP;
      case "daily":
        return AppIcons.dailyREP;
      case "weekly":
        return AppIcons.weeklyREP;
    }
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
        return ColorPallet.catTask;
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

  Color? _catagoryIconColor(String num) {
    switch (num) {
      case "task":
        return ColorPallet.icoTask;
      case "bad habbit":
        return ColorPallet.icoQuit;
      case "study":
        return ColorPallet.icoStudy;
      case "mentaly":
        return ColorPallet.icoMeditation;
      case "sport":
        return ColorPallet.icoSport;
      case "home":
        return ColorPallet.icoHome;
      case "health":
        return ColorPallet.icoHealth;
      case "social":
        return ColorPallet.icoSocial;
      case "work":
        return ColorPallet.icowork;
    }
    return null;
  }

  _deletBottomSheet(BuildContext context, TaskModel model) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 247, 245, 245),
        ),
        child: Column(
          children: [
            //grey puller line
            Container(
              width: 120,
              height: 6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
            ),
            const SizedBox(
              height: 40,
            ),
            //delete bootom
            InkWell(
              onTap: () {
                _controller.delete(model);
                _controller.getTask();
                Get.back();
              },
              child: Container(
                width: 320,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.red),
                child: Center(
                    child: Text(
                  "Delete Task",
                  style: GoogleFonts.lato(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //close button
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 320,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(0, 255, 255, 255)),
                child: Center(
                    child: Text(
                  "Close",
                  style: GoogleFonts.lato(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 2, 2, 2),
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: ColorPallet.white,
      elevation: 1,
    );
  }
}
