import 'package:flutter/material.dart';

class CertView extends StatefulWidget { //증명서 임시 페이지
  @override
  _CertViewState createState() => _CertViewState();
}

class _CertViewState extends State<CertView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('증명서'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Icon(Icons.assignment_outlined),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Icon(Icons.open_in_new_outlined),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Icon(Icons.cancel_outlined),
              ),
            ],
          )
        ],
      ),
    );
  }
}
