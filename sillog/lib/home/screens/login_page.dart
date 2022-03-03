import 'package:flutter/material.dart';
import 'package:sillog/home/screens/dev_page.dart';
import 'package:sillog/home/screens/login_google.dart';
import 'package:sillog/utils/utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _renderLogo(),
        _renderLoginTextField(),
        _renderSSO(),
      ],
    ));
  }

  _renderLogo() {
    return Center(
      child: Column(
        children: [
          SizedBox(
              width: 100,
              height: 165,
              child: Image.asset('assets/image/sillog_logo.png')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '나를 기록하고 증명하다',
              style: TextStyle(
                  color: SLG_COLOR,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  fontFamily: 'SpoqaHanSansNeo'),
            ),
          )
        ],
      ),
    );
  }

  _renderLoginTextField() {
    return SizedBox(
      height: 100,
    );
  }

  _renderSSO() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GoogleLogin(),
        SizedBox(height: 10),
        // DevButton(),
      ],
    );
  }
}
