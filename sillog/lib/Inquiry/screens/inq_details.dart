import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:get/get.dart';
import 'package:sillog/Inquiry/components/inq_floatAction.dart';
import 'package:sillog/Inquiry/controller/inq_controller.dart';
import 'package:sillog/Inquiry/controller/seq_floataction_controller.dart';
import 'package:sillog/Inquiry/data/model/inq_model.dart';
import 'package:sillog/Inquiry/screens/inq_detail_seq.dart';
import 'package:sillog/utils/app_colors.dart';
import 'package:sillog/widgets/appbar.dart';

class InqDetails extends StatefulWidget {
  //연속된 실록
  InqDetails({required this.data, required this.idx});

  int idx;
  final List<SillogModel> data;

  @override
  State<InqDetails> createState() => _InqDetailsState();
}

class _InqDetailsState extends State<InqDetails> {
  @override
  Widget build(BuildContext context) {
    FloatActionController floatActionController =
        Get.put(FloatActionController(widget.idx, widget.data));

    floatActionController.index = widget.idx;
    floatActionController.startLoading();
    floatActionController.getSillogList();
    return Scaffold(
      appBar: CustomAppBar(
          title: 'sillog',
          leading: true,
          color: Colors.white,
          backgroundColor: SLG_COLOR),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 30),
        child: InqSeqFloatAction(),
      ),
      body: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InqDetailSeq(index: index);
        },
        index: widget.idx,
        onIndexChanged: (index) {
          floatActionController.index = index;
          widget.idx = index;
          print('page index ${widget.idx}');
          print('floatActionController index ${floatActionController.index}');
        },
        itemCount: widget.data.length,
        pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                activeColor: Color(0xffF3F6F9), color: UNSELECT_COLOR)),
      ),
    );
  }
}
