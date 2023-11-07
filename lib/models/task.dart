class Task {
  dynamic id;
  late String title;
  late String date;

  Task(this.title, this.date);

  Task.fromMap(Map map) {
    id = map["id"];
    title = map["title"];
    date = map["date"];
  }

  Map<String, Object?> toMap() {
    Map<String, dynamic> map = {
      "title": title,
      "date": date,
    };

    if (id != null) map["id"] = id;

    return map;
  }
}
