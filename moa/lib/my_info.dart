import 'package:flutter/material.dart';
import 'file_control.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({Key? key}) : super(key: key);

  @override
  _MyInfoState createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  final List<String> _valueList = ['최저시급(8720원), 9000원, 10000원, 직접입력'];
  String _selectedValue = '최저시급(8720원)';
  FileController fileC = new FileController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text('내 정보'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                new Expanded(
                    child: new TextField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: '시급', hintText: '시급을 입력해주세요.'),
                      onChanged: (value) {
                        fileC.hourlyM = value;
                      },
                    )),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Center(
                //     child: DropdownButton(
                //       value: _selectedValue,
                //       items: _valueList.map((value){
                //         return DropdownMenuItem(
                //             value: _selectedValue
                //             ,child: Text(value));
                //       }).toList(),
                //       onChanged: (value){
                //         setState(() {
                //           _selectedValue = value as String;
                //         });
                //       },
                //     ),
                //   ),
                // )
              ],
            ),
            Row(
              children: [
                new Expanded(
                    child: new TextField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: '알바 시간(1주)', hintText: '총 시간을 입력해주세요.'),
                      onChanged: (value) {
                        fileC.totalHour = value;
                      },
                    )),

            ],),
            Row(
              children: [
                new Expanded(
                    child: new TextField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: '야간(1주)', hintText: '야간 시간을 입력해주세요.'),
                      onChanged: (value) {
                        fileC.nightTime = value;
                      },
                    )),
              ],
            ),
            Row(
              children: [
                new Expanded(
                    child: new TextField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: '야간(1주)', hintText: '야간 시간을 입력해주세요.'),
                      onChanged: (value) {
                        fileC.nightTime = value;
                      },
                    )),
              ],
            ),
            Row(
              children: [
                new Expanded(
                    child: new TextField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: '야간(1주)', hintText: '야간 시간을 입력해주세요.'),
                      onChanged: (value) {
                        fileC.nightTime = value;
                      },
                    )),
              ],
            ),
            Row(
              children: [
                new Expanded(
                    child: new TextField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: '야간(1주)',
                          hintText: '야간 시간을 입력해주세요.',
                      ),
                      onChanged: (value) {
                        fileC.nightTime = value;
                      },
                    )),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[ElevatedButton(onPressed: () {}, child: Text('OK'))],
    );
  }
}
