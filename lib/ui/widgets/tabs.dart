import 'package:chili/ui/constants.dart';
import 'package:chili/ui/screens/matches.dart';
import 'package:chili/ui/screens/messages.dart';
import 'package:chili/ui/screens/search.dart';
import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [Search(), Marches(), Messages()];

    return Theme(
        data:
            ThemeData(primaryColor: backgroundColor, accentColor: Colors.white),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Chill",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app))
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(48.0),
                child: Container(
                  height: 48.0,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.search)),
                          Tab(icon: Icon(Icons.people)),
                          Tab(icon: Icon(Icons.message))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: screens,
            ),
          ),
        ));
  }
}
