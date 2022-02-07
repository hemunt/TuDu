class Task {
  final int? id;
  final String title;
  final String description;

  Task({this.id, required this.title, required this.description});

  //  Helps us to create the map if the object  {Conversion of object to map}
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
    };
  }
}

class Todo {
  final String title;
  final int? taskId;
  final int? id;
  final int isDone;
  Todo({required this.title,this.id,required this.isDone,required this.taskId});
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "taskId":taskId,
      "title": title,
      "isDone": isDone,
    };
  }
}

