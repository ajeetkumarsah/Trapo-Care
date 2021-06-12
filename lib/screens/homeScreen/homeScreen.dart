import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:trapo_care/screens/tabs/edit/screen/list.dart';
import 'package:trapo_care/screens/tabs/posts/your_guide.dart';
import 'package:trapo_care/screens/tabs/resources/resourceScreen.dart';
import 'package:trapo_care/screens/tabs/updatedPosts/updatedScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: DefaultTabController(
        length: 4,
        initialIndex: 1,
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            backgroundColor: blueColor,
            leadingWidth: MediaQuery.of(context).size.width,
            bottom: TabBar(
              tabs: [
                new Container(
                  width: MediaQuery.of(context).size.width * 0.08,
                  child: new Tab(
                    icon: Image.asset(
                      pwhite,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                new Container(
                    width: 90,
                    child: new Tab(
                      text: 'Resources',
                    )),
                new Container(
                    width: MediaQuery.of(context).size.width * 0.17,
                    child: new Tab(
                      text: 'Leads',
                    )),
                new Container(
                    width: MediaQuery.of(context).size.width * 0.17,
                    child: new Tab(
                      text: 'Posts',
                    )),
              ],
              indicatorWeight: 7,
              indicatorColor: redColor,
              // labelStyle: TextStyle(
              //   fontSize: 16.0,
              // ),
              isScrollable: true,
            ),
            title: Container(
              width: 150,
              child: Image.asset(trapocarewhitered),
            ),
            actions: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: EdgeInsets.only(right: 5),
                  height: 18,
                  width: 20,
                  child: Image.asset(lwhite),
                ),
                Text("Kolkata",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    overflow: TextOverflow.ellipsis)
              ]),
              SizedBox(width: 20),
              SizedBox(
                width: 30,
              ),
            ],
          ),
          body: TabBarView(
            children: [
              EditScreen(),
              ResourceScreen(),
              UpdatedScreen(),
              YourGuideScreen(),
            ],
          ),
        ),
      )),
    );
  }
}
