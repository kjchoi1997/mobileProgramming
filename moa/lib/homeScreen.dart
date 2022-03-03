import 'package:flutter/material.dart ';
import 'my_info.dart';
import 'scholar.dart';
import 'part_time.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _tabController.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                PartTime(),
                Scholar(),
                MyInfo(),
              ]),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.all(0),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 1,
                  unselectedLabelColor: Colors.black38,
                  labelColor: Color(0xFF00FF00),
                  tabs: [
                    Tab(icon: Icon(Icons.wallet_travel, size: 21)),
                    Tab(icon: Icon(Icons.article_outlined, size: 21)),
                    Tab(icon: Icon(Icons.settings, size: 21)),
                  ],
                  controller: _tabController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
