class TaskModel {
  int? id;
  String? title;
  String? note;
  String? time;
  String? date;
  String? priorty;
  String? category;
  String? repeat;
  int? isCompelet;

  TaskModel({
    this.id,
    this.title,
    this.note,
    this.time,
    this.date,
    this.repeat,
    this.isCompelet,
    this.category,
    this.priorty,
  });

  TaskModel.fromJason(Map<String, dynamic> url) {
    id = url['id'];
    title = url['title'];
    note = url['note'];
    time = url['time'];
    date = url['date'];
    repeat = url['repeat'];
    isCompelet = url['isCompelet'];
    category = url['category'];
    priorty = url['priorty'];
  }

  Map<String, dynamic> toJason() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['note'] = note;
    data['time'] = time;
    data['date'] = date;
    data['repeat'] = repeat;
    data['isCompelet'] = isCompelet;
    data['category'] = category;
    data['priorty'] = priorty;
    return data;
  }
}
