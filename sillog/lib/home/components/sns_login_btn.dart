import 'package:flutter/material.dart';
import 'package:sillog/utils/utils.dart';

class SSOLoginBtn extends StatelessWidget {
  const SSOLoginBtn({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            elevation: 0.0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            side: BorderSide(
              color: SLG_COLOR,
            )),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                child: icon,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontFamily: 'SpoqaHanSansNeo',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
