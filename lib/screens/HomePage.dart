import 'package:flutter/material.dart';
import 'package:mytoodoo/Constents.dart';
import 'package:mytoodoo/MyWidgets.dart';
import 'package:mytoodoo/clock.dart';
import 'package:mytoodoo/databaseHelper.dart';
import 'package:mytoodoo/screens/TaskPage.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../taskModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper _db = DatabaseHelper();
  DateTime dateTimeNow = DateTime.now();
  String nameToShow = "";

  @override
  void initState() {
    super.initState();
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Logo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.account_circle,
                      color: textColor,
                    )),
                Container(
                  padding: EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                  ),
                  child: Image(
                    width: 30,
                    image: AssetImage(
                      "assets/images/Logo_small.png",
                    ),
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              child: Text(
                greeting(),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  color: textColor,
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),

            Container(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              child: Text(
                "Welcome to TuDu",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: mainColor,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //clock
            Center(
              child: Container(
                height: 250,
                width: 250,
                child: Clock(),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Center(
              child: Text(
                "See the time left for you to complete your tasks...",
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Tasks",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        " Lists",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return TaskPage(
                                task: Task(description: "", title: "", id: 0));
                          },
                        ),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: secondary,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: FutureBuilder(
                future: _db.getTasks(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) {
                                        return TaskPage(
                                          task: snapshot.data[index],
                                        );
                                      },
                                    ),
                                  ).then((value) {
                                    setState(() {});
                                  });
                                },
                                child: TaskCardWidget(
                                  title: snapshot.data[index].title,
                                  isBlue: snapshot.data[index].id,
                                  des: snapshot.data[index].description,
                                ),
                              );
                            },
                          ));
                    } else {
                      return Center(
                          child: Text(
                        "Press the + Button to add New Task List",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ));
                    }
                  } else {
                    return Text("Loading");
                  }
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
