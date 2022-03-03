import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sillog/Inquiry/controller/seq_floataction_controller.dart';
import 'package:sillog/Inquiry/data/model/inq_model.dart';
import 'package:sillog/Inquiry/screens/inq_details.dart';
import 'package:sillog/Inquiry/screens/inq_edit.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/home/screens/home.dart';
import 'package:sillog/utils/app_text_theme.dart';
import 'package:sillog/utils/utils.dart';
import 'package:sillog/widgets/dialog.dart';
import 'package:sillog/widgets/widgets.dart';

class InqFloatAction extends StatefulWidget {
  const InqFloatAction({Key? key, required this.sillog}) : super(key: key);
  final DetailModel sillog;

  @override
  _InqFloatActionState createState() => _InqFloatActionState();
}

class _InqFloatActionState extends State<InqFloatAction> {
  final sillogController = Get.find<SillogController>();
  bool clicked = false;

  _stateTag(bool value) async {
    if (value == false) {
      setState(() {
        clicked = value;
      });
    } else {
      setState(() {
        clicked = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: clicked == false ? 60 : 180,
      child: FloatingActionButton.extended(
        onPressed: () {
          _stateTag(true);
        },
        elevation: 0,
        highlightElevation: 0,
        label: clicked == false
            ? const Icon(Icons.add, size: 30)
            : Row(
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.5, right: 12.5),
                      child: const Icon(Icons.edit, size: 30),
                    ),
                    onTap: () async {
                      final sillogInfo =
                          await DetailModel.getDetail(widget.sillog);
                      sillogController.updateWithSillog(sillogInfo);
                      Get.to(InqEdit(),
                          arguments: widget.sillog,
                          transition: Transition.fadeIn);
                    },
                  ),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.5, right: 12.5),
                        child: const Icon(Icons.delete, size: 30),
                      ),
                      onTap: () async {
                        await Get.defaultDialog(
                          title: '삭제 중',
                          barrierDismissible: false,
                          titleStyle: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: SLG_COLOR),
                          backgroundColor: Colors.white,
                          radius: 10,
                          titlePadding: EdgeInsets.only(top: 30),
                          contentPadding: EdgeInsets.all(30),
                          content: FutureBuilder(
                              future: sillogController
                                  .sillogDeleteToServer(widget.sillog.id),
                              builder: (context, snapshot) {
                                if (snapshot.hasData == false) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('실록을 삭제하고 있습니다.',
                                          style: ThemeText.normal),
                                      // Text('감사합니다 :)', style: ThemeText.normal),
                                      SizedBox(height: 15),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                            Container(child: LOADING_INDICATOR),
                                      )
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return CircularProgressIndicator();
                                } else {
                                  Get.back();
                                  return Container();
                                }
                              }),
                        );
                        Get.offAll(() => Home());
                      }),
                  // InkWell(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 12.5, right: 12.5),
                  //     child: const Icon(Icons.open_in_new_outlined, size: 30),
                  //   ),
                  //   onTap: () {},
                  // ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.5, right: 12.5),
                      child: const Icon(Icons.more_horiz, size: 30),
                    ),
                    onTap: () {
                      _stateTag(false);
                    },
                  ),
                ],
              ),
        backgroundColor: Color(0xFF163C6B),
      ),
    );
  }
}

// class InqSeqFloatAction extends StatefulWidget {
//   //연속된 실록 수정 삭제 버튼
//   const InqSeqFloatAction({Key? key}) : super(key: key);

//   @override
//   _InqSeqFloatActionState createState() => _InqSeqFloatActionState();
// }

// class _InqSeqFloatActionState extends State<InqFloatAction> {
//   final sillogController = Get.find<SillogController>();
//   bool clicked = false;
//     VoidCallback? myCallback;

//   _stateTag(bool value) async {
//     if (value == false) {
//       setState(() {
//         clicked = value;
//       });
//     } else {
//       setState(() {
//         clicked = value;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       width: clicked == false ? 60 : 180,
//       child: FloatingActionButton.extended(
//         onPressed: () {
//           _stateTag(true);
//         },
//         elevation: 0,
//         highlightElevation: 0,
//         label: clicked == false
//             ? const Icon(Icons.add, size: 30)
//             : Row(
//                 children: [
//                   InkWell(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 12.5, right: 12.5),
//                       child: const Icon(Icons.edit, size: 30),
//                     ),
//                     onTap: () async {
//                       final sillogInfo =
//                           await DetailModel.getDetail(widget.sillog);
//                       sillogController.updateWithSillog(sillogInfo);
//                       Get.to(InqEdit(),
//                           arguments: widget.sillog,
//                           transition: Transition.fadeIn);
//                     },
//                   ),
//                   InkWell(
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 12.5, right: 12.5),
//                         child: const Icon(Icons.delete, size: 30),
//                       ),
//                       onTap: () => SLG_Dialog.checkDialog(
//                             middleText: '실록을 정말 삭제하시겠습니까?',
//                             title: '실록 삭제',
//                             onPressed: () async => {
//                               await sillogController
//                                   .sillogDeleteToServer(widget.sillog.id),
//                               Get.offAll(() => Home())
//                             },
//                           )),
//                   // InkWell(
//                   //   child: Padding(
//                   //     padding: const EdgeInsets.only(left: 12.5, right: 12.5),
//                   //     child: const Icon(Icons.open_in_new_outlined, size: 30),
//                   //   ),
//                   //   onTap: () {},
//                   // ),
//                   InkWell(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 12.5, right: 12.5),
//                       child: const Icon(Icons.more_horiz, size: 30),
//                     ),
//                     onTap: () {
//                       _stateTag(false);
//                     },
//                   ),
//                 ],
//               ),
//         backgroundColor: Color(0xFF163C6B),
//       ),
//     );
//   }
// }

class InqSeqFloatAction extends StatefulWidget {
  InqSeqFloatAction({Key? key}) : super(key: key);
  DetailModel? sillog;

  setSillog(var tmpSillog) {
    this.sillog = tmpSillog;
  }

  @override
  _InqSeqFloatActionState createState() => _InqSeqFloatActionState();
}

class _InqSeqFloatActionState extends State<InqSeqFloatAction> {
  final sillogController = Get.find<SillogController>();
  final floatButtonController = Get.find<FloatActionController>();
  bool clicked = false;

  _stateTag(bool value) async {
    if (floatButtonController.isLoading) return;

    if (value == false) {
      setState(() {
        clicked = value;
      });
    } else {
      setState(() {
        clicked = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: clicked == false ? 60 : 180,
      child: FloatingActionButton.extended(
        onPressed: () {
          _stateTag(true);
        },
        elevation: 0,
        highlightElevation: 0,
        label: clicked == false
            ? GetBuilder<FloatActionController>(builder: (controller) {
                return controller.isLoading
                    ? Icon(Icons.youtube_searched_for)
                    : Icon(Icons.add, size: 30);
              })
            : Row(
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.5, right: 12.5),
                      child: const Icon(Icons.edit, size: 30),
                    ),
                    onTap: () async {
                      if (floatButtonController.isLoading) return;
                      Get.to(InqEdit(),
                          arguments: floatButtonController
                              .detailsSillogMap[floatButtonController.index],
                          transition: Transition.fadeIn);
                    },
                  ),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.5, right: 12.5),
                        child: const Icon(Icons.delete, size: 30),
                      ),
                      onTap: () async {
                        if (floatButtonController.isLoading) return;
                        await Get.defaultDialog(
                          title: '삭제 중',
                          barrierDismissible: false,
                          titleStyle: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: SLG_COLOR),
                          backgroundColor: Colors.white,
                          radius: 10,
                          titlePadding: EdgeInsets.only(top: 30),
                          contentPadding: EdgeInsets.all(30),
                          content: FutureBuilder(
                              future: sillogController.sillogDeleteToServer(
                                  floatButtonController
                                      .sillogData[floatButtonController.index]
                                      .id),
                              builder: (context, snapshot) {
                                if (snapshot.hasData == false) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('실록을 삭제하고 있습니다.',
                                          style: ThemeText.normal),
                                      // Text('감사합니다 :)', style: ThemeText.normal),
                                      SizedBox(height: 15),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                            Container(child: LOADING_INDICATOR),
                                      )
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return CircularProgressIndicator();
                                } else {
                                  Get.back();
                                  return Container();
                                }
                              }),
                        );
                        Get.offAll(() => Home());
                      }),
                  // InkWell(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 12.5, right: 12.5),
                  //     child: const Icon(Icons.open_in_new_outlined, size: 30),
                  //   ),
                  //   onTap: () {},
                  // ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.5, right: 12.5),
                      child: const Icon(Icons.more_horiz, size: 30),
                    ),
                    onTap: () {
                      _stateTag(false);
                    },
                  ),
                ],
              ),
        backgroundColor: Color(0xFF163C6B),
      ),
    );
  }
}
