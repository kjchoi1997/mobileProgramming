// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Home extends StatefulWidget {
//   Home({Key key, this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// PageController pageController;
//
// class _HomeState extends State<Home> {
//   int _page = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         children: [
//           Container(
//             color: Colors.white,
//             child: InqTag(),
//           ),
//           Container(color: Colors.white, child: CertList()),
//           Container(
//             color: Colors.white,
//             child: RegEventInfo(),
//           ),
//           Container(color: Colors.white, child: RegComplete()),
//           Container(color: Colors.white, child: RegTag()),
//         ],
//         controller: pageController,
//         physics: NeverScrollableScrollPhysics(),
//         onPageChanged: onPageChanged,
//       ),
//       bottomNavigationBar: CupertinoTabBar(
//         backgroundColor: Colors.white,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.supervisor_account,
//                 color: (_page == 0) ? Colors.black : Colors.grey),
//             title: Text(
//               '조회',
//               style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: (_page == 0) ? Colors.black : Colors.grey),
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.web_asset,
//                 color: (_page == 1) ? Colors.black : Colors.grey),
//             title: Text(
//               '증명서',
//               style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: (_page == 1) ? Colors.black : Colors.grey),
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add_circle,
//                 color: (_page == 2) ? Colors.blue : Colors.blueGrey, size:40),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bar_chart,
//                 color: (_page == 3) ? Colors.black : Colors.grey),
//             title: Text(
//               '분석',
//               style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: (_page == 3) ? Colors.black : Colors.grey),
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings,
//                 color: (_page == 4) ? Colors.black : Colors.grey),
//             title: Text(
//               '설정',
//               style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: (_page == 4) ? Colors.black : Colors.grey),
//             ),
//           ),
//         ],
//         onTap: navigationTapped,
//         currentIndex: _page,
//       ),
//     );
//   }
//
//   void navigationTapped(int page) {
//     //Animating Page
//     pageController.jumpToPage(page);
//   }
//
//   void onPageChanged(int page) {
//     setState(() {
//       this._page = page;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     pageController = PageController();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     pageController.dispose();
//   }
// }
