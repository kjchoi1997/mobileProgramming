import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sillog/Registration/reg_memo.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegEventInfo extends StatefulWidget {
  @override
  _RegEventInfoState createState() => _RegEventInfoState();
}

class NameController extends GetxController {
  var evtName = ''.obs;
}

class _RegEventInfoState extends State<RegEventInfo> {
  TextEditingController _textController = TextEditingController();
  String ?_selectedDate;
  var evtName = ''.obs;

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    _selectedDate = DateFormat('yyyy.MM.dd', 'en').format(args.value);

    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _textController.addListener(() {
      setState(() {});
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('등 록', style: TextStyle(color: Colors.white)),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 0.1.h),
            child: LinearProgressIndicator(
              color: Color(0xFF163C6B),
              backgroundColor: Color(0xFFC4C4C4),
              value: 0.25,
            ),
          ),
          backgroundColor: Color(0xFF163C6B),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context); //뒤로가기
              },
              color: Colors.white,
              icon: Icon(Icons.navigate_before)),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.navigate_next),
                color: Colors.white,
                onPressed: () => Get.to(RegMemo(),
                    transition: Transition.rightToLeftWithFade)),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text("실록의 이름과 날짜를 입력해주세요!",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFF6F6F6),
                          border: Border.all(
                            color: Color(0xFFE8E8E8),
                          ),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            suffixIcon: _textController.text.length > 0
                                ? IconButton(
                                    icon: Icon(Icons.cancel_outlined,
                                        color: Color(0xFFBCBCBC)),
                                    onPressed: () {
                                      _textController.clear();
                                    },
                                  )
                                : null,
                          ),
                        ),
                      )),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20.0, bottom: 10.0),
                        child: Text('동일한 이름이라면 한 번에 묶을 수도 있어요!',
                            style: TextStyle(
                                fontSize: 12.sp, color: Color(0xFFA3A3A3))),
                      ),
                      _transaction(Image.asset('assets/image/face_grey.png'),
                          "알고리즘 스터디", "21.07.02"),
                      _transaction(Image.asset('assets/image/face_grey.png'),
                          "알고리즘 스터디", "21.07.02"),
                      _transaction(Image.asset('assets/image/face_grey.png'),
                          "알고리즘 스터디", "21.07.02"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getDateRangePicker(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () {},
                    child: Container(
                      child: _selectedDate == null
                          ? Text('날짜 선택', style: TextStyle(fontSize: 18))
                          : Text(_selectedDate),
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: ElevatedButton(
                      child: Text(
                        "다 음",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 47.h),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          primary: Color(0xFF163C6B)),
                      onPressed: () => {
                            Get.to(RegMemo(),
                                transition: Transition.rightToLeftWithFade),
                            evtName = _textController.text.obs,
                            print(evtName)
                          }),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _transaction(Image icon, String title, String time) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: InkWell(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(height: 30.0.h, width: 30.0.w, child: icon),
                SizedBox(
                  width: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 200.w,
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
                Text(
                  time,
                  style: TextStyle(color: Color(0xFFBCBCBC)),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 0.5,
              width: double.infinity,
              color: Colors.black12.withOpacity(0.1),
            )
          ],
        ),
        onTap: () {},
      ),
    );
  }

  Widget getDateRangePicker() {
    return Container(
        height: 300,
        width: 250,
        child: Card(
            child: SfDateRangePicker(
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.single,
          onSelectionChanged: selectionChanged,
        )));
  }
}
