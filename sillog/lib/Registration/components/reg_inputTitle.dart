import 'package:flutter/material.dart';
import 'package:sillog/Registration/components/reg_typeAhead.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';

class InputTitle extends StatefulWidget {
  const InputTitle({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  _InputTitleState createState() => _InputTitleState();
}

class _InputTitleState extends State<InputTitle> {
  late final SillogController sillogController;
  late final TextEditingController textController;

  @override
  initState() {
    super.initState();
    sillogController = SillogController();
    textController = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFF6F6F6),
            border: Border.all(
              color: Color(0xFFE8E8E8),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            )),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TypeAhead(
            controller: textController,
          ),
        ),
      ),
    );
  }
}
