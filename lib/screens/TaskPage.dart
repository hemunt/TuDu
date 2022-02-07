import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytoodoo/Constents.dart';
import 'package:mytoodoo/MyWidgets.dart';
import 'package:mytoodoo/databaseHelper.dart';

import '../taskModel.dart';

class TaskPage extends StatefulWidget {
  final Task task;

  TaskPage({required this.task});

  @override
  _TaskPage createState() => _TaskPage();
}

class _TaskPage extends State<TaskPage> {
  String _taskTitle = "";
  String todoTitle = "";
  int? _taskId = 0;
  bool _visible = false;
  String typedTitle = "";

  DatabaseHelper _db = DatabaseHelper();

  @override
  void initState() {
    if (widget.task.title != "") {
      _visible = true;
      _taskTitle = widget.task.title;
      _taskId = widget.task.id;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f4f6),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: mainColor,
                        size: 25,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 24.0,
                        right: 24.0,
                      ),
                      child: Image(
                        width: 25,
                        image: AssetImage(
                          "assets/images/Logo_small.png",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(top: 25.0, right: 30.0, left: 30.0),
                margin: EdgeInsets.only(top: 80.0),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                    ),
                    color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: TextEditingController()
                              ..text = widget.task.title != ""
                                  ? _taskTitle
                                  : typedTitle,
                            onChanged: (value) async {
                              typedTitle = value;
                            },
                            decoration: InputDecoration(
                                hintText: "Add Task List Name",
                                border: InputBorder.none),
                            style: TextStyle(
                                color: textColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      height: 40.0,
                      width: 100.0,
                      child: Material(
                        color: secondary,
                        borderRadius: BorderRadius.circular(20.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20.0),
                          onTap: () async {
                            if (widget.task.title == "") {
                              if (typedTitle != "") {
                                DatabaseHelper _dbhealper = DatabaseHelper();
                                Task _newTask = Task(
                                  title: typedTitle,
                                  description: " ",
                                );
                                _taskId = await _dbhealper.insertTask(_newTask);
                                print("Added id $_taskId");
                                FocusManager.instance.primaryFocus?.unfocus();
                                Navigator.pop(context);
                                setState(
                                  () {},
                                );
                              }
                            } else {}
                          },
                          child: Center(
                            child: Text(
                              "Add",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: _visible,
                child: Container(
                  margin: EdgeInsets.only(top: 180.0),
                  padding: EdgeInsets.only(top: 25.0, right: 30.0, left: 30.0),
                  width: double.infinity,
                  alignment: Alignment.topRight,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "All Tacks",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                          InkWell(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: EdgeInsets.only(
                                          top: 25.0, right: 30.0, left: 30.0),
                                      height: 700,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Type your task here",
                                            style: TextStyle(
                                                color: textColor,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 20.0,
                                                height: 20.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1.5)),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Expanded(
                                                child: TextField(
                                                  onChanged: (value) {
                                                    todoTitle = value;
                                                  },
                                                  decoration: InputDecoration(
                                                      hintStyle: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: textColor,
                                                      ),
                                                      hintText:
                                                          "Enter Todo Task..",
                                                      border: InputBorder.none),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 0.0,
                                          ),
                                          Container(
                                            height: 36.0,
                                            width: 80.0,
                                            child: Material(
                                              color: secondary,
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(14.0),
                                                onTap: () async {
                                                  if (widget.task.id != null) {
                                                    if (todoTitle != "") {
                                                      DatabaseHelper
                                                          _dbhealper =
                                                          DatabaseHelper();
                                                      Todo _newToto = Todo(
                                                        title: todoTitle,
                                                        isDone: 0,
                                                        taskId: widget.task.id,
                                                      );
                                                      await _dbhealper
                                                          .insertTodo(_newToto);
                                                      print("Added");
                                                    } else {
                                                      print("Noo");
                                                    }
                                                  }
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: Center(
                                                  child: Text(
                                                    "Add",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 35,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: _db.getTodo(_taskId),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ScrollConfiguration(
                                behavior: NoGlowBehaviour(),
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () async {
                                          if (snapshot.data[index].isDone ==
                                              0) {
                                            await _db.updateIsDone(
                                                snapshot.data[index].id, 1);
                                          } else {
                                            await _db.updateIsDone(
                                                snapshot.data[index].id, 0);
                                          }
                                          setState(() {});
                                        },
                                        child: ToDoWidgetWhite(
                                            taskText:
                                                snapshot.data[index].title,
                                            isDone:
                                                snapshot.data[index].isDone == 0
                                                    ? false
                                                    : true));
                                  },
                                ),
                              );
                            } else {
                              return Text("Loading");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20.0,
                right: 20.0,
                child: Container(
                  height: 50,
                  width: 50,
                  child: Material(
                    color: secondary,
                    borderRadius: BorderRadius.circular(14.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14.0),
                      onTap: () async {
                        if (_taskId != 0) {
                          await _db.deleteTask(_taskId);
                          Navigator.pop(context);
                        }
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
