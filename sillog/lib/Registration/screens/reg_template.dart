import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sillog/Registration/components/cancel_register_btn.dart';
import 'package:sillog/Registration/components/reg_templateWidget.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/Registration/screens/reg_question.dart';
import 'package:sillog/utils/app_text_theme.dart';
import 'package:sillog/utils/utils.dart';
import 'package:sillog/widgets/appbar.dart';

class RegTemplate extends StatefulWidget {
  @override
  _RegTemplateState createState() => _RegTemplateState();
}

class _RegTemplateState extends State<RegTemplate> {
  final questionController = Get.find<QuestionController>();
  @override
  Widget build(BuildContext context) {
    final categories = QnATemplate.keys.toList();
    return Scaffold(
      appBar: CustomAppBar(
        title: '등 록',
        step: 0.50,
        actions: [CancelRegisterButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                    child: Text("어떤 활동을 했나요?", style: RegText.INFO_TEXT),
                  ),
                ),
              ]),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 30.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 0.8),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return RegTemplateWidget(
                      text: categories[index],
                      onTap: () {
                        //   if (index == 0) {
                        //     Get.to(RegCustom(), transition: Transition.fadeIn);
                        //   } else {
                        questionController.categoriesName = categories[index];
                        Get.to(RegQuestion(),
                            // arguments: categories[index],
                            transition: Transition.fadeIn);
                        // }
                      });
                },
                childCount: categories.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
