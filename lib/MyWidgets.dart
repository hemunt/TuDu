import 'package:flutter/material.dart';
import 'package:mytoodoo/Constents.dart';
import 'package:mytoodoo/screens/TaskPage.dart';
import 'package:mytoodoo/taskModel.dart';
import 'databaseHelper.dart';

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String des;
  final int isBlue;


  DatabaseHelper _db = DatabaseHelper();

  TaskCardWidget(
      {this.title = "No title", this.des = "No des", required this.isBlue,});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding:
          EdgeInsets.only(left: 30.0, right: 30.0, top: 16.0, bottom: 10.8),
      margin: EdgeInsets.only(left:16.0, top: 10.0, bottom: 16.0, right: 16.0),
      width: 220,
      decoration: BoxDecoration(
        color: isBlue == 1 ? Colors.white : mainColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xffdfe7ee),
            spreadRadius: 2,
            offset: Offset(5, 5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    color: isBlue == 1 ? textColor : Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.subtitles_outlined,
                  color:isBlue == 1? textColor : Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            des == " " ? "Have to complete my tasks as soon as possible" : des,
            style: TextStyle(
              fontSize: 12,
                color: isBlue == 1 ? Colors.grey : Colors.white,
                fontWeight: FontWeight.w400),
          ),
          Expanded(
            child: FutureBuilder(
              future: _db.getTodo(isBlue),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ScrollConfiguration(
                    behavior: NoGlowBehaviour(),
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {

                          },
                          child: isBlue == 1
                              ? ToDoWidget(
                                  taskText: snapshot.data[index].title,
                                  isDone: snapshot.data[index].isDone == 0
                                      ? false
                                      : true)
                              : ToDoWidgetWhite(
                                  taskText: snapshot.data[index].title,
                                  isDone: snapshot.data[index].isDone == 0
                                      ? false
                                      : true),
                        );
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
    );
  }
}

class ToDoWidget extends StatelessWidget {
  final String taskText;
  final bool isDone;

  ToDoWidget({this.isDone = false, this.taskText = "unnamed todo task"});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0 ),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: isDone ? Color(0xffc6d6e1) : null,
                border:
                    isDone ? null : Border.all(color: textColor, width: 1.5)),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 18.0,
            ),
          ),
          SizedBox(
            width: 14.0,
          ),
          Flexible(
            child: Text(
              taskText,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: isDone ? FontWeight.w500 : FontWeight.bold,
                color: isDone ? textColor : textColor,
                decoration: isDone ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ToDoWidgetWhite extends StatelessWidget {
  final String taskText;
  final bool isDone;

  ToDoWidgetWhite({this.isDone = false, this.taskText = "unnamed todo task"});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: isDone ? Colors.white : null,
                border: isDone
                    ? null
                    : Border.all(color: Colors.white, width: 1.5)),
            child: isDone
                ? Icon(
                    Icons.check,
                    color: textColor,
                    size: 18.0,
                  )
                : null,
          ),
          SizedBox(
            width: 22.0,
          ),
          Flexible(
            child: Text(
              taskText,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: isDone ? FontWeight.w500 : FontWeight.bold,
                color: isDone ? Colors.white : Colors.white,
                decoration: isDone ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
