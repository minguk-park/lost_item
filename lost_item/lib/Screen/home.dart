import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        // leading: InkWell(
        //   splashColor: Colors.transparent,
        //   highlightColor: Colors.transparent,
        //   // onTap: () {
        //   //   exitDialog();
        //   // },
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(
        //       horizontal: 15.0,
        //     ),
        //     child: SvgPicture.asset(
        //       'asset/icon/exitBorder.svg',
        //       color: color2D2E33,
        //     ),
        //   ),
        // ),
        title: const Text(
          'Lost Item',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.amber,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(),
      ),
      // bottomNavigationBar: const AdmobBanner(),
    );
  }
}
