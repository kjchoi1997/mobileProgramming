import 'package:flutter/material.dart';
import 'package:sillog/utils/app_colors.dart';

class InqAppBar extends StatefulWidget {
  const InqAppBar({Key? key}) : super(key: key);

  @override
  _InqAppBarState createState() => _InqAppBarState();
}

class _InqAppBarState extends State<InqAppBar> {
  @override
  Widget build(BuildContext context) {
    bool appbar = false;

    _appbarDefalut() {
      setState(() => appbar = true);
    }

    _appbarCategory() {
      setState(() => appbar = false);
    }

    return Scaffold(
      appBar: appbar
          ? AppBar(
        title: const Text('기 술 태 그',
            style: TextStyle(color: Colors.white)),
        elevation: 0,
        backgroundColor: SLG_COLOR,
        leading: IconButton(
            onPressed: () {},
            color: Colors.white,
            icon: Icon(Icons.navigate_before)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_next),
            color: Colors.white,
            onPressed: () {},
          )
        ],
      )
          : AppBar(
        title:
        Text('Sillog', style: TextStyle(color: Colors.white)),
        elevation: 0,
        backgroundColor: SLG_COLOR,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            color: Colors.white,
            icon: Icon(Icons.menu)),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              color: Colors.white,
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {},
              color: Colors.white,
              icon: Icon(Icons.open_in_new_outlined))
        ],
      ),
    );
  }
}