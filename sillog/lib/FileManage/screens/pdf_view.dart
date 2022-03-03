import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sillog/home/components/slg_bottom_navigation_menu.dart';
import 'package:sillog/utils/utils.dart';

class PDFScreen extends StatefulWidget {
  final String? path;
  final String? sillogId;

  PDFScreen({Key? key, this.path, this.sillogId}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          elevation: 0.0,
          title: Text(widget.path != null ? basename(widget.path!) : 'pdf',
              style: TextStyle(color: SLG_COLOR)),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.shareFiles([widget.path!]);
              },
            ),
          ],
        ),
        bottomNavigationBar: SLGBottomNavigationMenu(ishome: false),
        body: Stack(
          children: <Widget>[
            PDFView(
              filePath: widget.path,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: true,
              pageSnap: true,
              defaultPage: currentPage!,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation:
                  false, // if set to true the link is handled in flutter
              onRender: (_pages) {
                setState(() {
                  pages = _pages;
                  isReady = true;
                });
              },
              onError: (error) {
                setState(() {
                  errorMessage = error.toString();
                });
                print(error.toString());
              },
              onPageError: (page, error) {
                setState(() {
                  errorMessage = '$page: ${error.toString()}';
                });
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onLinkHandler: (String? uri) {
                print('goto uri: $uri');
              },
              onPageChanged: (int? page, int? total) {
                print('page change: $page/$total');
                setState(() {
                  currentPage = page;
                });
              },
            ),
            errorMessage.isEmpty
                ? !isReady
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container()
                : Center(
                    child: Text(errorMessage),
                  )
          ],
        ),
        floatingActionButton: pages != 0
            ? Container(
                color: Colors.black54,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${(currentPage! + 1).toString()} of $pages',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : SizedBox()
        // floatingActionButton: FutureBuilder<PDFViewController>(
        //   future: _controller.future,
        //   builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
        //     if (snapshot.hasData) {
        //       return IconButton(
        //           onPressed: () {
        //             // TODO: sillog id 받아서 업데이트
        //             Get.to(InqDetail(), arguments: widget.sillogId);
        //           },
        //           icon: Image.asset('assets/image/logo.png'));
        //     }

        //     return Container();
        //   },
        // ),
        );
  }
}
