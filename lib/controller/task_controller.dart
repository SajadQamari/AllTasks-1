import 'package:get/get.dart';
import 'package:redo/database/data_base_service.dart';
import 'package:redo/model/task_model.dart';

class TaskController extends GetxController {
  
  @override
  void onReady() {
    getTask();
    super.onReady();
  }

  var taskList = <TaskModel>[].obs;
  Future<void> getTask() async {
    List<Map<String, dynamic>> task = await DatabaseService.query();
    // ignore: unnecessary_new
    taskList.assignAll(task.map((data) => TaskModel.fromJason(data)).toList());
  }

  void delete(TaskModel task) {
    DatabaseService.delete(task);
  }

  Future<void> markAsCompelet(int id) async {
    await DatabaseService.update(id);
    getTask();
  } 
  Future<void> undoCompelet(int id) async {
    await DatabaseService.undo(id);
    getTask();
  }

  Future<int> addTask({TaskModel? task}) async {
    return await DatabaseService.insert(task);
  }
}
