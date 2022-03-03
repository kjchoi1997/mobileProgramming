import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/Registration/data/model/reg_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sillog/utils/app_colors.dart';
import 'package:sillog/utils/app_text_theme.dart';

class TypeAhead extends StatefulWidget {
  final TextEditingController controller;

  //제목 자동완성
  const TypeAhead({Key? key, required this.controller}) : super(key: key);

  @override
  _TypeAheadState createState() => _TypeAheadState();
}

class _TypeAheadState extends State<TypeAhead> {
  @override
  Widget build(BuildContext context) {
    final titleController = Get.find<TitleController>();
    final textController = widget.controller;

    textController.addListener(() {
      setState(() {});
    });

    return TypeAheadField<SillogTitle?>(
      hideSuggestionsOnKeyboardHide: false,
      textFieldConfiguration: TextFieldConfiguration(
        keyboardType: TextInputType.text,
        controller: textController,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: textController.text.length > 0
              ? IconButton(
                  icon: Icon(Icons.cancel_outlined, color: LINE_COLOR),
                  onPressed: () {
                    textController.clear();
                  },
                )
              : null,
        ),
      ),
      suggestionsCallback: titleController.getSuggestions,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
          shadowColor: Colors.white,
          elevation: 0,
          constraints: BoxConstraints(maxHeight: 0.5.sh)),
      itemBuilder: (context, SillogTitle? suggestion) {
        final user = suggestion!;

        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: 200.w,
                              child: Text(user.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: RegText.CONTENTS_TEXT))
                        ],
                      ),
                      Text(user.regDate, style: TextStyle(color: LINE_COLOR)),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 0.5,
                    width: double.infinity,
                    color: Colors.white,
                  )
                ],
              ),
              onTap: () {
                print(widget.controller.text = suggestion.title);
                FocusScopeNode currentFocus = FocusScope.of(context);
                currentFocus.unfocus();
              },
            ),
          ),
        );
      },
      noItemsFoundBuilder: (context) => Container(
        height: 100,
        color: Colors.white,
        child: Center(
          child: Text('검색 결과가 없습니다.', style: RegText.HEAD_TEXT),
        ),
      ),
      onSuggestionSelected: (SillogTitle? suggestion) {
        // final User = suggestion!;
      },
    );
  }
}
