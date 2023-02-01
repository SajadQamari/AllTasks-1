import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:redo/controller/task_controller.dart';
import 'package:redo/controller/zoom_drawer_controller.dart';
import 'package:redo/model/task_model.dart';
import 'package:redo/services/notifications_services.dart';
import 'package:redo/views/add_task_page.dart';
import 'package:redo/views/components/configs.dart';
import 'package:redo/views/components/statics.dart';
import 'package:redo/views/full_view_task_page.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:redo/views/menu_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var userDate = DateTime.now();
  final ZoomControl _zoomControl = Get.put(ZoomControl());
  final TaskController _taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    var dayinit = DateTime.now().day;
    var monthinit = DateTime.now().month;
    var yearinit = DateTime.now().year;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: GetBuilder<ZoomControl>(
          builder: (_) {
            return ZoomDrawer(
              mainScreen: _mainScreen(yearinit, monthinit, dayinit),
              slideWidth: MediaQuery.of(context).size.width * 0.788, //!
              menuScreen: MenuScreen(),
              angle: 0.0,
              borderRadius: 30,
              showShadow: true,
              androidCloseOnBackTap: true,
              controller: _.zoomDrawerController,
              style: DrawerStyle.defaultStyle,
              menuBackgroundColor: ColorPallet.subPrimary,
              menuScreenOverlayColor: ColorPallet.white,
              duration: Duration(milliseconds: 500),
            );
          },
        ),

        //! action bottom
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            Get.off(() => const AddTask());
          }),
          elevation: 4,
          splashColor: ColorPallet.secendary,
          backgroundColor: ColorPallet.primary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Container _mainScreen(int yearinit, int monthinit, int dayinit) {
    return Container(
      child: Column(
        children: [
          //! App Bar
          Padding(
            padding: const EdgeInsets.only(left:20, top: 14),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      _zoomControl.toggleDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: ColorPallet.primary,
                      size: 40,
                    )),
                Text(
                  Strings.allTask,
                  style: AppTextStyle.appBar,
                ),
              ],
            ),
          ),
          //! welcome and Star
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //* welcom
                Column(
                  children: [
                    Text(
                      "Hey There ",
                      style: AppTextStyle.welcome,
                    ),
                    userDate.day == DateTime.now().day
                        ? Text("Today", style: AppTextStyle.welcome)
                        : Text(DateFormat.MMMd().format(userDate),
                            style: AppTextStyle.welcome), //? date NEED.
                  ],
                ),
                //* star
                // Container(
                //   width: 100,
                //   height: 40,
                //   decoration: BoxDecoration(
                //       color: ColorPallet.lightgrey,
                //       border: Border.all(
                //         color: ColorPallet.midGrey,
                //         width: 2,
                //       ),
                //       borderRadius: BorderRadius.circular(40)),
                //   child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         const Icon(
                //           Icons.star,
                //           size: 30,
                //           color: ColorPallet.yellow,
                //         ),
                //         Text(
                //           scoreController.val().toString(),
                //           style: AppTextStyle.welcome,
                //         ), //? Star NEED
                //       ]),
                // )
              ],
            ),
          ),
          //! date TimeLine
          _pickerTime(yearinit, monthinit, dayinit),
          //! divider
          _divider(),
          //! List
          //* today task string
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                Strings.todayTask,
                style: AppTextStyle.listTitle,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(() => const TaskView());
                  },
                  child: Text(
                    "See All",
                    style: AppTextStyle.seeAll,
                  ))
            ],
          ),
          //* Uploaded List
          _cartList()
          
          
        ],
      ),
    );
  }

  Padding _divider() {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Divider(
        color: ColorPallet.lightgrey,
        thickness: 2,
      ),
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
                                        child: CartTile(
                                          selectedDate: userDate,
                                          model: cart,
                                        ),
                                      )
                                    : CartTile(
                                        model: cart,
                                        selectedDate: userDate,
                                      )
                                :
                                //!weekly
                                cart.repeat == 'weekly'
                                    ? _weekChecker(userDate, cart.date!) == true
                                        ? cart.isCompelet == 1
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 30, left: 30),
                                                child: CartTile(
                                                  selectedDate: userDate,
                                                  model: cart,
                                                ),
                                              )
                                            : CartTile(
                                                model: cart,
                                                selectedDate: userDate,
                                              )
                                        : Container()
                                    :
                                    //!once
                                    cart.date ==
                                            DateFormat.yMd().format(userDate)
                                        ? cart.isCompelet == 1
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 30, left: 30),
                                                child: CartTile(
                                                  selectedDate: userDate,
                                                  model: cart,
                                                ),
                                              )
                                            : CartTile(
                                                model: cart,
                                                selectedDate: userDate,
                                              )
                                        : Container()),
                  ),
                ),
              );
            }));
      },
    ));
  }

  bool _weekChecker(DateTime pickedDate, String modelDate) {
    int j = 0, i = 0, day = 0, month = 0;

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
      if ((day - pickedDate.day) % 7 == 0) {
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
      if ((day - pickedDate.day) % 7 == 3) {
        return true;
      } else {
        return false;
      }
    } else if (month == 2) {
      if ((day - pickedDate.day) % 7 == 0) {
        return true;
      } else {
        return false;
      }
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
      if ((day - pickedDate.day) % 7 == 2) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
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
      }, //? NEED date time
    );
  }
}

// ignore: must_be_immutable
class CartTile extends StatelessWidget {
  CartTile({super.key, required this.model, required this.selectedDate});
  TaskModel model;
  DateTime selectedDate;
  final TaskController _controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    //! notification service
    NotificationService().showNotification(model.id!, model.title!, model.note!,
        selectedDate, _hourGetter(model.time!), _minuteGetter(model.time!));

    return InkWell(
      onTap: () {
        Get.to(() => const TaskView());
      },
      onLongPress: () {
        _deletBottomSheet(context, model);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
        height: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorPallet.backgroundMainCarts),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //! details
            Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      model.title!,
                      style: AppTextStyle.titleCartView,
                    )),
                Row(
                  children: [
                    _priordyicon(model.priorty!),
                    _repeatyicon(model.repeat!),
                    _catagoryicon(model.category!),
                  ],
                )
              ],
            ),
            //! time and checkBox
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    model.isCompelet == 0
                        ? _controller.markAsCompelet(model.id!)
                        : _controller.undoCompelet(model.id!);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: ColorPallet.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorPallet.secendary)),
                    child: model.isCompelet == 0
                        ? Container()
                        : const Center(
                            child: Icon(Icons.done),
                          ),
                  ),
                ),
                Text(
                  model.time!,
                  style: AppTextStyle.timeCartView,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _minuteGetter(String dateTime) {
    int firstElement = int.parse(dateTime[3]) * 10;
    int secondElement = int.parse(dateTime[4]);

    return firstElement + secondElement;
  }

  int _hourGetter(String dateTime) {
    int firstElement = int.parse(dateTime[0]) * 10;
    int secondElement = int.parse(dateTime[1]);
    int hour = firstElement + secondElement;
    if (dateTime[6] == 'P') {
      hour += 12;
      if (hour == 24) {
        return 0;
      } else {
        return hour;
      }
    } else
      return hour;
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

  _deletBottomSheet(BuildContext context, TaskModel model) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 247, 245, 245),
        ),
        child: Column(
          children: [
            //!grey puller line
            Container(
              margin: EdgeInsets.only(bottom: 40),
              width: 120,
              height: 6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
            ),
            //!delete bootom
            InkWell(
              onTap: () {
                _controller.delete(model);
                _controller.getTask();
                NotificationService().cancelNotification(model.id!);
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
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
            //!close button
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
