import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'taskModel.dart';

class DatabaseHelper {
  Future<Database> dataBase() async {
    return openDatabase(
      join(await getDatabasesPath(), "todo_db.db"),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)",
        );


        await db.execute(
          'CREATE TABLE todo(id INTEGER PRIMARY KEY,taskId INTEGER, title TEXT, isDone INTEGER)',
        );
      },
      version: 1,
    );
  }
Future<void> firstAdd()async{
  Database _db = await dataBase();
  Task newOne =Task(title: "Daily Tasks", description: "Here is the list of Daily tasks you have to do on daily bases");
  await _db
      .insert(
    "tasks",
    newOne.toMap(),
  );
}

  Future<void> updateTask(int id, String newTitle) async {
    Database _db = await dataBase();
    _db.rawUpdate("UPDATE tasks SET title = '$newTitle' WHERE id = '$id'");
  }
  Future<void> updateIsDone(int id, int isDone) async {
    Database _db = await dataBase();
    _db.rawUpdate("UPDATE todo SET isDone = '$isDone' WHERE id = '$id'");
  }
  Future<void> deleteTask(int? id) async {
    Database _db = await dataBase();
   await _db.rawDelete("DELETE FROM tasks WHERE id = '$id'");
   await _db.rawDelete("DELETE FROM todo WHERE taskId = '$id'");

  }

  Future<int> insertTask(Task task) async {
    int taskId = 0;
    Database _db = await dataBase();
    await _db
        .insert(
      "tasks",
      task.toMap(),
    )
        .then((value) {
      taskId = value;
    });
    return taskId;
  }

  Future<void> insertTodo(Todo todo) async {
    Database _db = await dataBase();
    await _db.insert(
      "todo",
      todo.toMap(),
    );
  }

  
  Future<String> getName()async{
    String nameToShow = "";
    Database _db = await dataBase();
    List<Map<String, dynamic>> name = await _db.rawQuery("SELECT name FROM username");
    List.generate(name.length, (index) {
      nameToShow = name[index]['name'];
    });
    return nameToShow;
  }

  Future<List<Task>> getTasks() async {
    Database _db = await dataBase();
    List<Map<String, dynamic>> taskMap = await _db.query("tasks");
    return List.generate(taskMap.length, (index) {
      return Task(
          id: taskMap[index]["id"],
          title: taskMap[index]["title"],
          description: taskMap[index]["description"]);
    });
  }

  Future<List<Todo>> getTodo(int? taskId) async {
    Database _db = await dataBase();
    List<Map<String, dynamic>> todoMap =
        await _db.rawQuery("SELECT * FROM todo WHERE taskID = $taskId");
    return List.generate(todoMap.length, (index) {
      return Todo(
          id: todoMap[index]["id"],
          title: todoMap[index]["title"],
          taskId: todoMap[index]["taskId"],
          isDone: todoMap[index]["isDone"]);
    });
  }
}
